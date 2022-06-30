def find_all_nets_at_heir_level(workspace, hier_path, top_lib, top_cell, top_view="schematic"):
    """Get list of nets at a certrain hierarchical level in the given lib-cell-veiw.

    Args:
        workspace (Workspace): A open Skillbridge Workspace object, connected to a specified project virtuoso session.
        hier_path (str): The hierarchical level path to search for nets. (example: '/XDUT/' or '/' or '/XDUT/XDUT/')
        top_lib (str): The top library name of the view being parsed.
        top_cell (str): The top cell name of the view being parsed.
        top_view (:obj:`str`, optional): The top view name of the view being parsed. Defaults to 'schematic'.

    Returns:
        list: List of nets found in the given top lib-cell-view at the hierarchical level.
    """
    return workspace['SchFindAllNetsAtHierLevel'](hier_path, topLib=top_lib, topCell=top_cell, topView=top_view)
