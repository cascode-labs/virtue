printf("Initializing Virtue menu items\n")

;Popup Menu for libraries, cells, and views
lmgrCreateMenuItem( "CopyPath" "simple"
   '(("label" "Copy Path" )
     ("callback" ("VrtPathCopyCallback")) ))
lmgrAddMenuItems( "editCascade" "LCVlcv" '("CopyPath") )

; Library Manager Virtue Menu
lmgrCreateMenu("VirtueMenu" '(("label" "Virtue")))

lmgrCreateMenuItem( "SkillBridgeToggle" "toggle"
   '(("label" "Start SkillBridge Server" )
     ("callback" ("VrtSkillbridgeTogglePythonServerLmgrCallback")) ))
lmgrAddMenuItems("VirtueMenu" "" '("SkillBridgeToggle"))

lmgrCreateMenuItem("HelpSeperator" "separator" nil)

lmgrCreateMenu("VirtueHelpMenu" '(("label" "Help")))
lmgrCreateMenuItem("VirtueHelp" "simple"
   '(("label" "Virtue Help" )
     ("callback" ("VrtOpenDocumentationLmgrCallback")) ))
lmgrCreateMenuItem( "SkillBridgeHelp" "simple"
     '(("label" "SkillBridge Help" )
       ("callback" ("VrtSkillbridgeOpenDocumentationLmgrCallback")) ))
lmgrAddMenuItems("VirtueHelpMenu" "" '("VirtueHelp" "SkillBridgeHelp"))
lmgrAddMenuItems("VirtueMenu" "" '("VirtueHelpMenu"))

lmgrAddMenuItems("menuBar" "L" '("VirtueMenu"))

printf("Done, Initialized ids-skill menu items\n")
