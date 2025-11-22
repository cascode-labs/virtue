from typing import Any, Optional,TypedDict

class FunctionTypeDict(TypedDict):
    name: str
    parameters: Optional[list[str]]
    doc_string: Optional[str]

def generate_markdown(filepath: str):
    return None
    
def read_skill_functions(skill_code: str) -> Optional[dict[str,FunctionTypeDict]]:
    if not "procedure(" in skill_code:
        return None
    else:
        functions ={}
    skill_code_lines = skill_code.splitlines()
    check_for_docstring = False
    inside_docstring = False
    for line in skill_code_lines:
        line = line.strip()
        if check_for_docstring and  line.startswith("\"") and line.endswith("\""):
            functions[name]["doc_string"] = line[1:len(line)-1]
            check_for_docstring = False
        elif check_for_docstring and line.startswith("\""):
            functions[name]["doc_string"] = line[1:len(line)]
            check_for_docstring = False
            inside_docstring = True
        elif inside_docstring and line.endswith("\""):
            functions[name]["doc_string"] += " " + line[0:len(line)-1]
            inside_docstring = False
        elif inside_docstring:
            functions[name]["doc_string"] += " " + line
        if "procedure(" in line:
            name_start = line.find("procedure(")+10
            name_end = line.find("(", name_start)
            parameters_end = line.find(")", name_end)
            if parameters_end > name_end+1:
                parameters = line[name_end+1:parameters_end]
                parameters = parameters.split(" ")
            else:
                parameters = None
            name = line[name_start:name_end]
            functions[name] = {
                "name": name, 
                "parameters": parameters,
                "doc_string": None
            }
            check_for_docstring = True
    return functions
