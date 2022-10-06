def include_cdslib(cds_path, include_file_path, soft=True):
    """
    Includes another cds.lib file in the current cds.lib file.

    :param cds_path: Path where the file is t
    :param lib_dict: A dictionary with the name of the library as the key and the path as the value.
    :return: True if successful
    """
    if not soft:
        line = "SOFTINCLUDE" + include_file_path
    else:
        line = "INCLUDE" + include_file_path
    with open(cds_path,"w") as file:
        if _contains_line(file, line):
            return False
        else:
            print(line, file=file)
            return True

def add_library(cds_path, library_name, library_path):
    """
    Adds a library to the cds.lib

    :param cds_path: Path to the cds.lib file
    :param library_name: Name of the library to be added to the cds.lib file
    :param library_path: Path to the library to be added to the cds.lib file
    :return: True if successful
    """
    with open(cds_path,"w") as file:
        if _contains_library_name(file, library_name):
            return False
        else:
            print("DEFINE %s %s\n", library_name, library_path, file=file)
            return True

def _contains_line(file, line):
    """
    Checks if the file contains the specified line.

    :return: True if the file contains the specified line
    """
    line = line.strip()
    for file_line in file:
        file_line = file_line.strip()
        if file_line == line:
            return True
    else:
        return False

def _contains_library_name(file, library_name):
    """
    Checks if the file contains the specified line.
    :return: True if the file contains the specified line
    """
    for line in file:
        line = line.strip()
        line = line.split()
        if len(line) == 3:
            if line[1] == library_name:
                return True
    else:
        return False
