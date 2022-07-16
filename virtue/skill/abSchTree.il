/* abSchTree.il

Author     A.D.Beckett
Group      Custom IC, Cadence Design Systems Ltd.
Machine    SUN
Date       Oct 30, 1995 
Modified   Nov 07, 2010 
By         A.D.Beckett

Function to perform the equivalent of the "tree" function
for schematics

There are three entry points in this file:

(abSchTree [optional key arguments])
    Low level entry point - no form. Just uses arguments to define how and
    where the tree gets created

(abHdbSchTree [optional key arguments])
    Low level entry point - no form. Just uses arguments to define how and
    where the tree gets created. Similar to abSchTree, but for
    config views.

(abHiSchTree)
    Form interface to abSchTree and abHdbSchTree.

Extended to support configs in July 2006, as well as allowing
output methods to be supplied, so that output can be sent 
elsewhere in different formats.

***************************************************

SCCS Info: @(#) abSchTree.il 01/13/12.14:08:45 1.9

*/

/***************************************************************
*                                                              *
*               (abCompareCellName inst1 inst2)                *
*                                                              *
*       Comparison function when sorting the instHeaders       *
*                                                              *
***************************************************************/

(defun abCompareCellName (inst1 inst2)
  (let (result)
       (forall property '(libName cellName viewName)
               (equal (setq result 
                            (strcmp (dbGet inst1 property)
                                    (dbGet inst2 property))) 0))
       (lessp result 0)))

/***************************************************************
*                                                              *
*                   (abSchTreeOutputElement                    *
*              obj indent instInfo lib cell view               *
*                 boundLib boundCell boundView                 *
*             displaySwitchedView isStoppingView)              *
*                                                              *
*   Generic function to output an element into the tree. Is    *
*   passed a whole bunch of information that could be useful   *
*                    to the output function                    *
*                                                              *
***************************************************************/

(defgeneric abSchTreeOutputElement 
            (obj indent instInfo lib cell view 
                 boundLib boundCell boundView
                 displaySwitchedView isStoppingView)
            nil
            )

/***************************************************************
*                                                              *
*               (abSchTreeOutputPush obj indent)               *
*                                                              *
* Generic function called whenever the hierarchy is descended  *
*   in the tree. Allows the output formatter to do something   *
*    if needed. There is no method for port, so normally it    *
*                     doesn't do anything.                     *
*                                                              *
***************************************************************/

(defgeneric abSchTreeOutputPush 
            (obj indent) 
            nil
            )

/***************************************************************
*                                                              *
*               (abSchTreeOutputPop obj indent)                *
*                                                              *
* Generic function whenever the hierarchy is ascended. Similar *
*                   to abSchTreeOutputPush.                    *
*                                                              *
***************************************************************/

(defgeneric abSchTreeOutputPop 
            (obj indent) 
            nil
            )

/***************************************************************
*                                                              *
*                    abSchTreeOutputElement                    *
*                                                              *
*  Method specialized on port - is the normal element output   *
*                    for the tree utility.                     *
*                                                              *
***************************************************************/

(defmethod abSchTreeOutputElement 
  ((obj port) indent instInfo lib cell view 
              _boundLib _boundCell boundView
              displaySwitchedView _isStoppingView)
  (let (displayedView formatString)
    (if (and displaySwitchedView boundView)
      (sprintf displayedView " [%s]" boundView)
      (setq displayedView "")
      )
    (sprintf formatString "%%%ds %%s %%s %%s %%s%%s\n"
             indent)
    (fprintf obj formatString "" 
             lib
             cell
             view
             instInfo
             displayedView
             )
    )
  )

/************************************************************************
*                                                                       *
*            (abSchTree @key (cellView (geGetEditCellView))             *
*                (viewList "schematic cmos.sch symbol")                 *
*                          (stopList "symbol")                          *
*                             (port poport)                             *
*                           (displayPins nil)                           *
*                              (indent 0))                              *
*                           (useViewSwitching t)                        *
*                           (libStopList nil))                          *
*                                                                       *
* Recursive function to output a "tree" like display from the specified *
* cellView downwards using the specified view and stop lists. The pins  *
*  can be displayed as well if desired. The indent is for internal use  *
*   only and controls the indent level that this cellView's instances   *
*                            are printed at.                            *
*     libStopList allows libraries to be filtered - this is a space     *
* separated string of library names to ignore. Setting useViewSwitching *
*                to nil means it is suitable for layouts.               *
*                                                                       *
************************************************************************/

(defun abSchTree (@key (cellView (geGetEditCellView)) 
                      (viewList "schematic cmos.sch symbol")
                      (stopList "symbol")
                      libStopList
                      (port poport)
                      (displayPins nil)
                      (displaySwitchedView nil)
                      (useViewSwitching t)
                      (indent 0))
  (let (sortedHeaders count stopAtList isStoppingView
                      switchedView)
       (setq stopAtList (parseString stopList))
       (unless (listp libStopList) (setq libStopList (parseString libStopList)))
       (setq sortedHeaders 
             (sort (dbGetq cellView instHeaders) 'abCompareCellName))
       (foreach header sortedHeaders
                ;--------------------------------------------------------
                ; count the number of instances
                ;--------------------------------------------------------
                (setq count (length
                             (if displayPins 
                                 ;---------------------------------------
                                 ; if we're displaying pins, count them 
                                 ; all regardless 
                                 ;---------------------------------------
                                 (dbGetq header instances)
                                 ;---------------------------------------
                                 ; otherwise only count those without 
                                 ; purpose pin
                                 ;---------------------------------------
                                 (setof inst 
                                        (dbGetq header instances) 
                                        (nequal (dbGetq inst purpose) "pin")))))
                ;--------------------------------------------------------
                ; when there was at least one 
                ; (so that pins can be filtered out)
                ;--------------------------------------------------------
                (when (greaterp count 0)
                  ;--------------------------------------------------
                  ; Stop if the library is in the stop list
                  ;--------------------------------------------------
                  (unless (member (dbGetq header libName) libStopList)
                    ;----------------------------------------------------
                    ; switch views (unless asked not to)
                    ;----------------------------------------------------
                    (if useViewSwitching
                      ; then
                      (progn
                        (setq switchedView (dbGetAnyInstSwitchMaster 
                                             (car (dbGetq header instances))
                                             viewList))
                        (setq isStoppingView
                              (and switchedView 
                                   (member (dbGetq switchedView viewName)
                                           stopAtList)))
                        )
                      ; else
                      (progn
                        (setq switchedView (dbGetq header master))
                        (setq isStoppingView nil)
                        )
                      )
                    (abSchTreeOutputElement
                      port 
                      indent
                      (sprintf nil "(%d)" count)
                      (dbGetq header libName)
                      (dbGetq header cellName)
                      (dbGetq header viewName)
                      (dbGetq header libName)
                      (dbGetq header cellName)
                      (dbGetq switchedView viewName)
                      displaySwitchedView
                      isStoppingView)
                    ;----------------------------------------------------
                    ; Recursively expand the hierarchy
                    ;----------------------------------------------------
                    (when switchedView
                      (unless isStoppingView
                        (abSchTreeOutputPush port indent)
                        (abSchTree ?cellView switchedView
                                   ?viewList viewList
                                   ?stopList stopList
                                   ?libStopList libStopList
                                   ?port port
                                   ?displayPins displayPins
                                   ?displaySwitchedView
                                   displaySwitchedView
                                   ?useViewSwitching useViewSwitching
                                   ?indent (plus indent 2))
                        (abSchTreeOutputPop port indent)
                        )
                      ;----------------------------------------------
                      ; I did try closing the switched cell, but it
                      ; didn't work properly. Have to live with this, 
                      ; I suppose!
                      ;----------------------------------------------
                      )
                    )
                  )
                )
       t))

/***************************************************************
*                                                              *
*  (abHdbSchTree @key libName cellName viewName (port poport)  *
*         (displayPins nil) (displaySwitchedView nil)          *
*    (indent 0) (collapseStoppingViews t) (physConfig nil)     *
*                        (libStopList nil))                    *
*                                                              *
*    Similar to abSchTree, but works on config views. As a     *
*      result, the lib, cell, and view of the config view      *
*      need to be passed in (as it opens the config). The      *
*       main difference in arguments is the presence of        *
*      the collapseStoppingViews argument. Because there       *
*    may be instance and occurrence bindings in the config,    *
*   we normally have to descend into every occurence in the    *
*    hierarchy. The collapseStoppingViews argument is used     *
*   to only output instances which are at stop points once,    *
*     with a count - but can be turned off to output every     *
*  instance regardless. physConfig is to say that this is a    *
*    physical config view. Only limited support for these.     *
*                                                              *
***************************************************************/

(defun abHdbSchTree (@key 
                      libName
                      cellName
                      viewName
                      (port poport)
                      (displayPins nil)
                      (displaySwitchedView nil)
                      (indent 0)
                      (collapseStoppingViews t)
                      libStopList
                      physConfig
                      )
  (let (configId pathVectorStack configBag)
    (setq configBag (hdbCreateConfigBag))
    (setq configId 
          (if physConfig
            (hdbOpen libName cellName viewName "r" "CDBA" "physExpand.cfg")
            (hdbOpen libName cellName viewName "r")
            )
          )
    (setq pathVectorStack (hdbCreatePathVectorStack))
    (if configId
      (progn
        (abHdbSchTreeTraverseConfig
          ?port port
          ?displayPins displayPins
          ?displaySwitchedView displaySwitchedView
          ?indent indent
          ?pathVectorStack pathVectorStack
          ?configId configId
          ?configBag configBag
          ?collapseStoppingViews collapseStoppingViews
          ?libStopList libStopList
          )
        (hdbCloseConfigsInBag configBag)
        )
      (error "Could not open config %Y/%Y/%Y\n" libName cellName viewName)
      ) ; if
    ) ; let
  ) ; defun abHdbSchTree

/*****************************************************************
*                                                                *
*                  (abHdbSchTreeTraverseConfig                   *
* @key (port poport) (displayPins nil) (displaySwitchedView nil) *
*         (indent 0) pathVectorStack configId configBag          *
*                   (collapseStoppingViews t))                   *
*                        (libStopList nil))                      *
*                                                                *
*   Given an open config, path vector stack, and a config bag,   *
*   traverse the config. This is called from abHdbSchTree, but   *
*    may also be called from abHdbSchTreeTraverseCellView if     *
*         a config is switched into from another config.         *
*                                                                *
*****************************************************************/

(defun abHdbSchTreeTraverseConfig (@key 
                                    (port poport)
                                    (displayPins nil)
                                    (displaySwitchedView nil)
                                    (indent 0)
                                    pathVectorStack
                                    configId
                                    configBag
                                    (collapseStoppingViews t)
                                    libStopList
                                    )
  (let (libName cellName viewName pathVector)
    (hdbAddConfigToBag configBag configId)
    ;--------------------------------------------------------------------
    ; Find out the cellView associated with the config
    ;--------------------------------------------------------------------
    (setq libName (hdbGetTopLibName configId))
    (setq cellName (hdbGetTopCellName configId)) 
    (setq viewName (hdbGetTopViewName configId)) 
    ;--------------------------------------------------------------------
    ; Create a path vector to manage the hierarchy traversal, and 
    ; then push it onto the stack 
    ;-------------------------------------------------------------------- 
    (setq pathVector (hdbCreatePathVector configId))
    (hdbPushPathVect pathVectorStack pathVector) 
    ;-------------------------------------------------------------------- 
    ; Traverse the cellView 
    ;--------------------------------------------------------------------
    (abHdbSchTreeTraverseCellView
      ?libName libName
      ?cellName cellName
      ?viewName viewName
      ?port port
      ?indent indent
      ?displayPins displayPins
      ?displaySwitchedView displaySwitchedView
      ?pathVectorStack pathVectorStack
      ?configBag configBag
      ?collapseStoppingViews collapseStoppingViews
      ?libStopList libStopList
      )
    ;--------------------------------------------------------------------
    ; Cleanup. All the configs will be closed at the top level
    ;--------------------------------------------------------------------
    (hdbPopPathVect pathVectorStack)
    (hdbDestroyPathVector pathVector)
    ) ; let
  ) ; defun abHdbSchTreeTraverseConfig

/*************************************************************************
*                                                                        *
*                     (abHdbSchTreeTraverseCellView                      *
*              @key libName cellName viewName (port poport)              *
*         (displayPins nil) (displaySwitchedView nil) (indent 0)         *
*          pathVectorStack configBag (collapseStoppingViews t))          *
*                            (libStopList nil))                          *
*                                                                        *
*        The function which does all the work for cellViews under        *
*     configs. This uses pcdb to iterate over the instance masters,      *
*    and then the instances (it can iterate over both the structural     *
* instances, plus any "ignored" instances like pins, taps, sheets, etc). *
*              Recursively descends through the hierarchy.               *
*                                                                        *
*************************************************************************/

(defun abHdbSchTreeTraverseCellView (@key
                                      libName
                                      cellName
                                      viewName
                                      (port poport)
                                      (displayPins nil)
                                      (displaySwitchedView nil)
                                      (indent 0)
                                      pathVectorStack
                                      configBag
                                      (collapseStoppingViews t)
                                      libStopList
                                      )
  (let (pathVector pcId instMasterGens instMaster instGen inst
                   masterLibName masterCellName masterViewName
                   fixedLib fixedCell fixedView instName bindInfo
                   boundLib boundCell boundView 
                   isStoppingView deferredInfo newInfo instInfo
                   expandMasterGens deferredCount)
    (unless (listp libStopList) (setq libStopList (parseString libStopList)))
    (setq pathVector (hdbGetPathVectorStackTop pathVectorStack))
    (setq pcId (pcdbOpen libName cellName viewName "r"))
    (when pcId
      ;------------------------------------------------------------------
      ; Create a list of one or two inst master generators, depending
      ; on whether pins (i.e. "ignored" instances) are traversed. A
      ; second list is created indicating whether expansion should 
      ; happen or not for that masterGen - it shouldn't happen for
      ; the "ignored" instances.
      ;------------------------------------------------------------------
      (setq instMasterGens
            `(,(pcdbGetInstMasterGen pcId)
               ,@(and displayPins (list (pcdbGetIgnoredInstMasterGen pcId)))
               ))
      (setq expandMasterGens `(t ,@(and displayPins (list nil))))
      ;------------------------------------------------------------------
      ; Loop over the one or two inst master generators
      ;------------------------------------------------------------------
      (foreach
        (instMasterGen expandMasterGen) instMasterGens expandMasterGens
        (setq instMaster (pcdbNextInstMaster instMasterGen))
        (while instMaster
               ;---------------------------------------------------------
               ; Gather information about the master
               ;---------------------------------------------------------
               (setq masterLibName (pcdbInstMasterLib instMaster))
               (setq masterCellName (pcdbInstMasterCell instMaster))
               (setq masterViewName (pcdbInstMasterView instMaster))
               (setq fixedLib (pcdbInstMasterLibFixed instMaster))
               (setq fixedCell (pcdbInstMasterCellFixed instMaster))
               (setq fixedView (pcdbInstMasterViewFixed instMaster))
               (unless (member masterLibName libStopList)
                 ;-------------------------------------------------------
                 ; Now traverse the instances
                 ;-------------------------------------------------------
                 (setq instGen (pcdbGetInstGen instMaster))
                 (setq inst (pcdbNextInst instGen))
                 (while inst
                        (setq instName (pcdbInstName inst))
                        (setq bindInfo
                              (and expandMasterGen
                                   (hdbBind 
                                     pathVector
                                     masterLibName
                                     masterCellName
                                     masterViewName
                                     instName
                                     fixedLib
                                     fixedCell
                                     fixedView
                                     t
                                     )))
                        (setq boundLib (car bindInfo))
                        (setq boundCell (cadr bindInfo))
                        (setq boundView (caddr bindInfo))
                        ;------------------------------------------------
                        ; Only push if the view was bound
                        ;------------------------------------------------
                        (if (and boundLib boundCell boundView)
                          (progn
                            (hdbPushCell 
                              pathVector instName boundLib boundCell boundView)
                            (setq isStoppingView (hdbIsAtStopPoint pathVector))
                            )
                          ;----------------------------------------------
                          ; Otherwise pretend it is a stopping view to prevent
                          ; hierarchy expansion
                          ;----------------------------------------------
                          (setq isStoppingView t)
                          )
                        (when collapseStoppingViews
                          ;----------------------------------------------
                          ; This is a collection of data used to see if
                          ; this instances is the same as the deferred instance
                          ;----------------------------------------------
                          (setq newInfo
                                (list 
                                  instName 
                                  masterLibName masterCellName masterViewName
                                  boundLib boundCell boundView))
                          ;----------------------------------------------
                          ; Output the deferred instance information if
                          ; this is either not a stopping view, or it
                          ; is different from the deferred instance
                          ;----------------------------------------------
                          (when
                            (and
                              (or (null isStoppingView)
                                  (nequal (cdr newInfo) (cdr deferredInfo)))
                              deferredInfo)
                            (if (greaterp deferredCount 1)
                              (sprintf instInfo "(%d)" deferredCount)
                              (setq instInfo (car deferredInfo)))
                            (abSchTreeOutputElement
                              port 
                              indent
                              instInfo
                              (nth 1 deferredInfo)
                              (nth 2 deferredInfo)
                              (nth 3 deferredInfo)
                              (nth 4 deferredInfo)
                              (nth 5 deferredInfo)
                              (nth 6 deferredInfo)
                              displaySwitchedView
                              t
                              ) 
                            ) ; when
                          ;----------------------------------------------
                          ; Now either update the count, or record the 
                          ; deferred instance, or discard the current data
                          ; about the deferred instance
                          ;----------------------------------------------
                          (cond
                            ((and isStoppingView
                                  (equal (cdr newInfo) (cdr deferredInfo)))
                             (postincrement deferredCount))
                            (isStoppingView
                              (setq deferredInfo newInfo)
                              (setq deferredCount 1)
                              )
                            (t
                              (setq deferredInfo nil)
                              )
                            ) ; cond
                          ) ; when
                        ;------------------------------------------------
                        ; Output normally if not collapsing, or this is
                        ; not a stopping view
                        ;------------------------------------------------
                        (unless (and collapseStoppingViews isStoppingView)
                          (abSchTreeOutputElement
                            port 
                            indent
                            instName
                            masterLibName
                            masterCellName
                            masterViewName
                            boundLib
                            boundCell
                            boundView
                            displaySwitchedView
                            isStoppingView
                            )
                          ) ; unless
                        ;------------------------------------------------
                        ; Now descend if necessary
                        ;------------------------------------------------
                        (unless isStoppingView
                          (abSchTreeOutputPush port indent)
                          (if (hdbIsConfig boundLib boundCell boundView)
                            ;--------------------------------------------
                            ; If a sub-config, traverse that
                            ;--------------------------------------------
                            (let (configId)
                              (setq configId 
                                    (hdbOpen boundLib boundCell boundView "r"))
                              (abHdbSchTreeTraverseConfig
                                ?port port
                                ?displayPins displayPins
                                ?displaySwitchedView displaySwitchedView
                                ?indent (plus indent 2)
                                ?pathVectorStack pathVectorStack
                                ?configId configId
                                ?configBag configBag
                                ?collapseStoppingViews collapseStoppingViews
                                ?libStopList libStopList
                                )
                              )
                            ;--------------------------------------------
                            ; Otherwise traverse the bound cellView
                            ;--------------------------------------------
                            (abHdbSchTreeTraverseCellView
                              ?libName boundLib
                              ?cellName boundCell
                              ?viewName boundView
                              ?port port
                              ?indent (plus indent 2)
                              ?displayPins displayPins
                              ?displaySwitchedView displaySwitchedView
                              ?pathVectorStack pathVectorStack
                              ?configBag configBag
                              ?collapseStoppingViews collapseStoppingViews
                              ?libStopList libStopList
                              )
                            ) ; if
                          (abSchTreeOutputPop port indent)
                          ) ; unless isStoppingView
                        ;------------------------------------------------
                        ; Pop back up again
                        ;------------------------------------------------
                        (when (and boundLib boundCell boundView)
                          (hdbPopCell pathVector)
                          )
                        (setq inst (pcdbNextInst instGen))
                        ) ; while inst
                 ;-------------------------------------------------------
                 ; Output any deferred instances from collapsing that
                 ; are left over before moving onto the next master
                 ;-------------------------------------------------------
                 (when deferredInfo
                   (if (greaterp deferredCount 1)
                     (sprintf instInfo "(%d)" deferredCount)
                     (setq instInfo (car deferredInfo)))
                   (abSchTreeOutputElement
                     port 
                     indent
                     instInfo
                     (nth 1 deferredInfo)
                     (nth 2 deferredInfo)
                     (nth 3 deferredInfo)
                     (nth 4 deferredInfo)
                     (nth 5 deferredInfo)
                     (nth 6 deferredInfo)
                     displaySwitchedView
                     t
                     ) 
                   (setq deferredInfo nil)
                   )
                 ) ; unless member libStopList
               ;---------------------------------------------------------
               ; Move to next instance master
               ;---------------------------------------------------------
               (setq instMaster (pcdbNextInstMaster instMasterGen))
               ) ; while instMaster
        ) ; foreach instMasterGen
      (pcdbClose pcId)
      ) ; when
    ) ; let
  ) ; defun


/***************************************************************
*                                                              *
*                   (abCreateHiSchTreeForm)                    *
*                                                              *
*       Create the form for the schematic tree function        *
*                                                              *
***************************************************************/

(defun abCreateHiSchTreeForm ()
  (let (topOrCurrent viewList stopList displayPins displaySwitchedView
                     libStopList)
       (setq topOrCurrent 
             (hiCreateRadioField
              ?name 'topOrCurrent
              ?prompt "Starting cell"
              ?choices '("current" "top")))
       (setq viewList
             (hiCreateStringField
              ?name 'viewList
              ?prompt "View list"
              ?value "schematic cmos.sch symbol"))
       (setq stopList
             (hiCreateStringField
              ?name 'stopList
              ?prompt "Stop list"
              ?value "symbol"))
       (setq libStopList
             (hiCreateStringField
              ?name 'libStopList
              ?prompt "Ignore libraries"
              ?value ""))
       (setq displayPins
             (hiCreateBooleanButton
              ?name 'displayPins
              ?buttonText "Display pins"
              ?value nil))
       (setq displaySwitchedView
             (hiCreateBooleanButton
              ?name 'displaySwitchedView
              ?buttonText "Display view used"
              ?value nil))
       (setq abHiSchTreeForm
             (hiCreateAppForm
              ?name 'abHiSchTreeForm
              ?formTitle "Schematic Tree"
              ?callback 'abHiSchTreeCB
              ?fields (list
                       topOrCurrent viewList stopList libStopList
                       displayPins displaySwitchedView)))
       abHiSchTreeForm))

/***************************************************************
*                                                              *
*                     (abHiSchTreeCB form)                     *
*                                                              *
*            Callback for the schematic tree form.             *
*      Opens the file, outputs the header information and      *
*     then calls abSchTree to recursively descend down the     *
*                          hierarchy.                          *
*         Then the output file is viewed and deleted.          *
*                                                              *
***************************************************************/

(defun abHiSchTreeCB (form)
  (let (cellView oport fileName)
       (setq cellView
             (if (equal (getq (getq form topOrCurrent) value) "top")
                 (geGetTopLevelCellView (getq form treeWindow))
                 (geGetEditCellView (getq form treeWindow))))
       (if cellView
           (progn
            (setq oport (outfile (setq fileName 
                                       (makeTempFileName "/tmp/schTree"))))
            (if oport
                (progn
                 (fprintf oport "%40s\n","Design Hierarchy")
                 (fprintf oport 
                  "*******************************************************\n")
                 (fprintf oport "Library : %s\n" (dbGetq cellView libName))
                 (fprintf oport "Cell    : %s\n" (dbGetq cellView cellName))
                 (fprintf oport "View    : %s\n" (dbGetq cellView viewName))
                 (fprintf oport "Option  : %s to bottom\n" 
                          (getq (getq form topOrCurrent) value))
                 (fprintf oport 
                  "*******************************************************\n\n"
                  )
                 (abSchTree ?cellView cellView
                            ?viewList (getq (getq form viewList) value)
                            ?stopList (getq (getq form stopList) value)
                            ?libStopList (getq (getq form libStopList) value)
                            ?displayPins (getq (getq form displayPins) value)
                            ?displaySwitchedView 
                                (getq (getq form displaySwitchedView) value)
                            ?port oport
                            )
                 (close oport)
                 (view fileName nil "Tree")
                 (deleteFile fileName)
                 )
                (error "Couldn't open output file"))
            )
           (error "Couldn't find cellView"))
       ))

/********************************************************************
*                                                                   *
*                    (abCreateHiHdbSchTreeForm)                     *
*                                                                   *
* Since the form fields for expanding a config view are pretty much *
* completely different from a normal view, create a separate form.  *
*               Easier than having the form dynamic.                *
*                                                                   *
********************************************************************/

(defun abCreateHiHdbSchTreeForm ()
  (let (displayPins displaySwitchedView collapseStoppingViews libStopList)
       (setq displayPins
             (hiCreateBooleanButton
              ?name 'displayPins
              ?buttonText "Display pins"
              ?value nil))
       (setq displaySwitchedView
             (hiCreateBooleanButton
              ?name 'displaySwitchedView
              ?buttonText "Display view used"
              ?value nil))
       (setq collapseStoppingViews
             (hiCreateBooleanButton
              ?name 'collapseStoppingViews
              ?buttonText "Collapse stopping views"
              ?value t))
       (setq libStopList
             (hiCreateStringField
               ?name 'libStopList
               ?prompt "Ignore libraries"
               ?value ""
               ))
       (hiCreateAppForm
         ?name 'abHiHdbSchTreeForm
              ?formTitle "Schematic Tree from config"
              ?callback 'abHiHdbSchTreeCB
              ?fields (list
                       displayPins
                       displaySwitchedView
                       collapseStoppingViews
                       libStopList))
       ) ; let
  ) ; defun

/****************************************************************
*                                                               *
*                    (abHiHdbSchTreeCB form)                    *
*                                                               *
*   Form callback for config tree expansion. Opens the file,    *
* writes out the header, and then calls the expansion function. *
*       Then closes the file and displays it in a window.       *
*                                                               *
****************************************************************/

(defun abHiHdbSchTreeCB (form)
  (let (config oport fileName)
    (setq config (getq form config))
    (setq oport (outfile (setq fileName 
                               (makeTempFileName "/tmp/schTree"))))
    (if oport
      (progn
        (fprintf oport "%40s\n","Design Hierarchy")
        (fprintf oport 
                 "*******************************************************\n")
        (fprintf oport "Library     : %s\n" (hdbGetLibName config))
        (fprintf oport "Cell        : %s\n" (hdbGetCellName config))
        (fprintf oport "View        : %s\n" (hdbGetViewName config))
        (fprintf oport "Top Library : %s\n" (hdbGetTopLibName config))
        (fprintf oport "Top Cell    : %s\n" (hdbGetTopCellName config))
        (fprintf oport "Top View    : %s\n" (hdbGetTopViewName config))
        (fprintf oport 
                 "*******************************************************\n\n"
                 )
        (abHdbSchTree 
          ?libName (hdbGetLibName config)
          ?cellName (hdbGetCellName config)
          ?viewName (hdbGetViewName config)
          ?displayPins (getq (getq form displayPins) value)
          ?displaySwitchedView (getq (getq form displaySwitchedView) value)
          ?collapseStoppingViews (getq (getq form collapseStoppingViews) value)
          ?libStopList (getq (getq form libStopList) value)
          ?port oport
          )
        (close oport)
        (view fileName nil "Tree")
        (deleteFile fileName)
        )
      (error "Couldn't open output file"))
    ) ; let
  ) ; procedure

/***************************************************************
*                                                              *
*                        (abHiSchTree)                         *
*                                                              *
*        Display a form controlling the tree generation        *
*                                                              *
***************************************************************/

(defun abHiSchTree ()
  (let (wid config)
    (setq wid (hiGetCurrentWindow))
    (setq config (deGetConfigId wid))
    (if config
      ; then 
      (progn
        ;----------------------------------------------------------------
        ; create the form if it doesn't exist
        ;----------------------------------------------------------------
        (unless (and (boundp 'abHiHdbSchTreeForm) abHiHdbSchTreeForm)
          (abCreateHiHdbSchTreeForm))
        (putpropq abHiHdbSchTreeForm config config)
        (hiDisplayForm abHiHdbSchTreeForm)
        )
      ; else
      (progn
        ;----------------------------------------------------------------
        ; create the form if it doesn't exist
        ;----------------------------------------------------------------
        (unless (and (boundp 'abHiSchTreeForm) abHiSchTreeForm)
          (abCreateHiSchTreeForm))
        ;----------------------------------------------------------------
        ; store the window on the form so that it will always use the window
        ; that was current when the command was invoked
        ;----------------------------------------------------------------
        (putpropq abHiSchTreeForm wid treeWindow)
        (hiDisplayForm abHiSchTreeForm)
        )
      ) ; if
    ) ; let
  ) ; defun
  
  
  
  
  
  
  
  
  
  
  
  
  
/* abCollectCellViewsInConfig.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Feb 07, 2019 
Modified   
By         

Uses abSchTree.il to collect information about non-stopping
views in a design hierarchy. Can be passed a schematic view
and a viewList and stopList, or a config view.

e.g.

abCollectCellViewsInConfig("worklib" "top" "config")

returns:

(("worklib" "comparator" "verilogams") 
    ("worklib" "samplehold" "verilogams") 
    ("diglib" "sareg" "module") 
    ("worklib" "daconv" "verilogams") 
    ("diglib" "vhdl_clock" "vhdl_behavioral")
    ("worklib" "signalSrc" "verilogams") 
    ("worklib" "top" "schematic") 
    ("worklib" "myreg" "behavioral")
)

***************************************************

SCCS Info: @(#) abCollectCellViewsInConfig.il 02/07/19.16:44:01 1.1

*/

;------------------------------------------------------------------------
; A class for holding the information during abSchTree,
; and for collecting the cellView information
;------------------------------------------------------------------------
defclass(abCollectCellViewsSchTreeClass ()
  (
   (cellViewTable @initarg cellViewTable)
   )
  )


/***************************************************************
*                                                              *
*                    abSchTreeOutputElement                    *
*                                                              *
*   A method to simply collect the non-stopping views in the   *
*  design hierarchy - called each time a bound view is found   *
*         when abSchTree is traversing teh hierarchy.          *
*                                                              *
***************************************************************/

defmethod(abSchTreeOutputElement 
        ((obj abCollectCellViewsSchTreeClass) _indent _instInfo _lib _cell
            _view boundLib boundCell boundView
            _displaySwitchedView isStoppingView)
    ;--------------------------------------------------------------------
    ; Record the usage of this cellView
    ;--------------------------------------------------------------------
    unless(isStoppingView || 
            obj->cellViewTable[list(boundLib boundCell boundView)]
        obj->cellViewTable[list(boundLib boundCell boundView)]= t
    ) 
)

/*********************************************************************
*                                                                    *
*        abCollectCellViewsInConfig(libName cellName viewName        *
*  @key (viewList "schematic cmos.csh symbol") (stopList "symbol"))  *
*                                                                    *
*    Function to traverse the design hierarchy using abSchTree or    *
* abHdbSchTree, and return a list of lists of lib/cell/views used in *
*             the design (not including stopping views)              *
*                                                                    *
*********************************************************************/

procedure(abCollectCellViewsInConfig(libName cellName viewName 
        @key (viewList "schematic cmos.csh symbol") (stopList "symbol"))
    let((obj lcv config)
    ;--------------------------------------------------------------------
    ; Create the object which will be used in lieu of a port in
    ; abSchTree/abHdbSchTree
    ;--------------------------------------------------------------------
    obj=makeInstance( 
        'abCollectCellViewsSchTreeClass
        ?cellViewTable makeTable('cellViews nil)
    )
    ;--------------------------------------------------------------------
    ; Open the config - if indeed it was a config passed in
    ;--------------------------------------------------------------------
    config=
        hdbIsConfig(libName cellName viewName) &&
        hdbOpen(libName cellName viewName "r")
    if(config then
        ;----------------------------------------------------------------
        ; Record top cell in cellView table
        ;----------------------------------------------------------------
        lcv=list(
                hdbGetTopLibName(config)
                hdbGetTopCellName(config)
                hdbGetTopViewName(config)
                )
        obj->cellViewTable[lcv]=t
        abHdbSchTree( 
            ?libName libName
            ?cellName cellName 
            ?viewName viewName 
            ?displaySwitchedView t 
            ?port obj
        )
        hdbClose(config)
    else
        ; else it's a normal design
        lcv=list(libName cellName viewName)
        obj->cellViewTable[lcv]=t
        abSchTree(
            ?cellView dbOpenCellViewByType(libName cellName viewName)
            ?displaySwitchedView t
            ?viewList viewList
            ?stopList stopList
            ?port obj
            )
    )
    ;--------------------------------------------------------------------
    ; Return the cellViews used in the design
    ;--------------------------------------------------------------------
    obj->cellViewTable->?
    )
)