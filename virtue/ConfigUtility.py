def create_config_view(workspace, config_lcv, top_cell_lcv, library_list, view_list, stop_list):
    """Creates a config view in a given lib-cell-view. Sets the top cell lib-cell-view based on given. Sets the config
       library list, view list, and stop list in the global binding section.

    Args:
        workspace (Workspace): A open Skillbridge Workspace object, connected to a specified project virtuoso session.
        config_lcv (list(str str str)): A list containing the library, cell, and view name of where the config will
            be created.
        top_cell_lcv (list(str str str)): A list containing the library, cell, and view name of the Top Cell in the
            created config.
        library_list (str): String of library names separated by spaces.
        view_list (str):  String of view names separated by spaces.
        stop_list (str): String of stops separated by spaces.

    Returns:
         (bool) Returns true is successful, false otherwise
    """
    return workspace['HdbCreateConfigView'](config_lcv, top_cell_lcv, library_list, view_list, stop_list)
