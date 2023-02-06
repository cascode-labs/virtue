procedure(VrtAnalog2DecimalBit(in)
  "Converts an analog input into a digital 1 or 0 in decimal format."
  if(in > 0.9 then
    1
  else
    0
  )
)

procedure(VrtAnalog2Decimal(@rest inputs)
  "Converts a set of analog bits into a digital decimal number"
  let(((out_decimal 0) (n 0))
  inputs = reverse(inputs)
  for(n 0 (length(inputs)-1)
    out_decimal = out_decimal + (2**n) * VrtAnalog2DecimalBit(nth(n inputs))
  )
  out_decimal
))

procedure(VrtDecimal2Hex(input @optional (prefix 't))
  "Converts a decimal between 0 and 15 into a hex digit (string)
   When the optional prefix input is true (default) then '0x ' will be prepended to the hex digit.
   A space is included between '0x' and the hex output since otherwise "
  let((out_hex)
  if(input < 16 then
    out_hex = upperCase(sprintf(nil "%x" input))
  else
    out_hex = upperCase(sprintf(nil "%x" (input-mod(input 16))/16 ))
    out_hex = strcat(out_hex upperCase(sprintf(nil "%x" mod(input 16))))
  )
  if(prefix then
    ; A sm
    out_hex = strcat("0x " out_hex)
  )
  out_hex
))

procedure(VrtAnalog2Hex(@rest inputs)
  "Converts 4 analog bits into a hex digit. (string)
   When the optional prefix input is true (default) then 0x will be prepended to the hex digit."
  VrtDecimal2Hex(apply('VrtAnalog2Decimal inputs))
)