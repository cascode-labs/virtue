procedure(Test_Str_lint()
  let((filepath)
  filepath = StrPathConcat(VrtGetCurrentFileDirectory() "../virtue/skill/Str.ils")
  assert(sklint(
    ?file filepath
    ?globals list("Str")
    ?prefixes list("Str")
  ))
))


Test->run(list(
  Test_Str_lint
))
