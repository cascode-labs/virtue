import os
import warnings


def get_project_name_list():
    """ Gets a list of project names sorted in alphabetical order .

    Order example: ['Cat', 'cobra', 'whale', 'Whale', 'zebra']

    Returns:
        List[str]: Directory names at '/prj'.
    """
    return sorted(os.listdir('/prj'), key=str.lower)


def cell_view_exists(workspace, lib_name, cell_name, view_name):
    """Checks if lib-cell-view exists.

    Args:
        workspace (Workspace): A open Skillbridge Workspace object, connected to a specified project virtuoso session.
        lib_name (str): The library name of the view being checked.
        cell_name (str): The cell name of the view being checked.
        view_name (str): The view name of the view being checked.

    Returns:
        bool: True if lib-cell-view exists, False otherwise.
    """
    warnings.simplefilter("ignore")
    result = workspace.db.open_cell_view_by_type(lib_name, cell_name, view_name, "", "r")
    return True if result else False


def get_view_write_path(workspace, lib_name, cell_name, view_name, file_name='text.txt'):
    """Get write path to a specified view.

    Args:
        workspace (Workspace): A open Skillbridge Workspace object, connected to a specified project virtuoso session.
        lib_name (str): The library name of the view being checked.
        cell_name (str): The cell name of the view being checked.
        view_name (str): The view name of the view being checked.
        file_name (:obj:`str`, optional): The file name to be looked for in the specified lib, cell, and view names. Defaults to 'text.txt'.

    Returns:
        str: Write path to the given lib-cell-view, None if file cannot be found.
    """
    return workspace['getWritePathFromLCV'](lib_name, cell_name, view_name, file_name)


def get_library_dict(workspace):
    """Get library names and their related cell and view names.

        Example: {'library_0': {'cell_A': ['view_0', 'view_1'], 'cell_B': []}, 'library_1': {}}

    Args:
        workspace (Workspace): A open Skillbridge Workspace object, connected to a specified project virtuoso session.

    Returns:
        dict(library_name: dict(cell-views))
    """
    result = workspace.dd.get_lib_list()
    lib_cell_view_dict = {library_object.name: _get_cells_in_lib(library_object.cells) for library_object in result}
    return lib_cell_view_dict


def _get_cells_in_lib(cell_objects):
    """ Get cell names and their related view names.

        Example: {'cell_A': ['view_0', 'view_1'], 'cell_B': [], 'cell_C': ['view_0']}
        Example: dict()

    Args:
        cell_objects(List[obj]): List of cell_objects with name and views properties.

    Returns:
        dict(cell_name: List[view_name]) if cell_objects is not None else empty dictionary, dict()
    """
    return {cell_object.name: _get_views_in_cell(cell_object.views) for cell_object in cell_objects} if cell_objects else {}


def _get_views_in_cell(view_objects):
    """Get list of view names.

       Example: ['view_0', 'view_1', 'view_2']
       Example: list()

    Args:
        view_objects(list(object)): List of view objects found in a cell.

    Returns:
        List[view_names] if view_objects is not None else list()
    """
    return [view_object.name for view_object in view_objects] if view_objects else []
