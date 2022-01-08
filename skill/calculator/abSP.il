/* /export/home/andrewb/skill/abSP.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       Oct 08, 2019 
Modified   
By         

Wrapper around aaSP to cope with families. May need some work yet...

The idea is to allow:

abSP(VAR("P1") VAR("P2"))

to be used.

***************************************************

SCCS Info: @(#) abSP.il 10/08/19.14:53:45 1.1

*/

procedure(abSP(port1 port2)
  cond(
    (stringp(port1)
      aaSP(port1 port2)
    )
    (drIsWaveform(port1)
      ; not entirely convinced this is right yet - may need some refinement
      aaSP(
	drGetElem(drGetWaveformYVec(port1) 0)
	drGetElem(drGetWaveformYVec(port2) 0)
      )
    )
    (famIsFamily(port1)
      famMap('abSP port1 port2)
    )
    (t
      error("abSP: don't know how to handle %L %L" port1 port2)
    )
  )
)

;
;;;;;;;;;;;;;;;;;;;;;;;;;; GUI builder information ;;;;;;;;;;;;;;;;;;;;;;;;;;;
ocnmRegGUIBuilder(
 '(nil
  function abSP
  name abSP
  description "abSP"
  category ("Custom Functions")
  analysis (nil
      general (nil
        args (port1 port2 )
          params(nil
                 port1 (nil
                       prompt "port1"
                       tooltip "port1"
                       guiRowHint 0
                       type string
                       enableListener port
                       default "/PORT1"
                       required t
                 )
                 port2 (nil
                       prompt "port2"
                       tooltip "port2"
                       guiRowHint 1
                       type string
                       enableListener port
                       default "/PORT0"
                       required t
                 )
          )
        inputrange t
      )
  )
  outputs(result)
 )
)
