from virtue.skill_docs import read_skill_functions


skill_code_example = """
procedure(emptyp(in "g")
	"Checks if the input is an empty string"
	stringp(in) && strlen(in) == 0)


procedure(split(in delim "tt")
	"Similar to parseString, except multiple delim are not ignored.
	 Empty delimiter fields are returned as empty strings."
	let(((out '()) (inTmp in) nextC)
	while(nextC = nindex(inTmp,delim)
		out = append1(out substring(inTmp 1 nextC-1))
		inTmp = substring(index(inTmp delim) 2)
	)
	append1(out inTmp)
))

"""

def test_read_skill_functions():
    functions = read_skill_functions(skill_code_example)
    assert(functions is not None)
    assert(isinstance(functions, dict))
    assert(functions["emptyp"]["name"]=="emptyp")
    assert(functions["emptyp"]["parameters"]==["in", "\"g\""])
    assert(functions["emptyp"]["doc_string"]
           == "Checks if the input is an empty string")
    assert(functions["split"]["name"]=="split")
    assert(functions["split"]["parameters"]==["in", "delim", "\"tt\""])
    assert(functions["split"]["doc_string"]
           == ("Similar to parseString, except multiple delim are not ignored."
	 	   + " Empty delimiter fields are returned as empty strings."))
    assert(len(functions) == 2)
	# assert(1)
