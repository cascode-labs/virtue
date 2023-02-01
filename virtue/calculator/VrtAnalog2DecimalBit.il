procedure(VrtAnalog2DecimalBit(in)
  "Converts an analog input into a digital 1 or 0 in decimal format."
  if(in > 0.9 then
    1
  else
    0
  )
)

;;; GUI builder information ;;;;;;;;;;;;;;;;;;;;;;;;;;;                
ocnmRegGUIBuilder(
  '(nil
    function VrtAnalog2DecimalBit
    name VrtAnalog2DecimalBit 
    description "Converts an analog input into a digital 1 or 0 in decimal format."
    category ("Special Functions" "Digital")
    analysis (nil
      general (nil
        args (signal)
        signals (nil
          signal (nil
            prompt "Signal"
            tooltip "Signal to convert to a digital integer")
        )
        inputrange t
      )
    )
    outputs (result)
))
