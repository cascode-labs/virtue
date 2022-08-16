import os


def get_workspace_id(project_name=None, user_name=None):
    """ Gets the workspace id in the format expected by the Skill side of Skillbridge connection.

    Args:
        project_name(:obj:`str`, optional): Name of project that will a skill bridge workspace will connect to.
          Defaults to the value of 'PROJ_ID' environment variable.
        user_name(:obj:`str`, optional): Name of user the skill bridge connection workspace will be connected to.
          Defaults to the value of 'USER' environment variable.

    Returns:
        str: A workspace id in the format '{project_name}-{user_name}.

    Raises:
        ValueError: An error occurred if the project name or username is not provided and the associated environement
          variable does not exits.
    """
    project_name = get_current_project_name() if not project_name else project_name
    user_name = get_current_user_name() if not user_name else user_name
    if not project_name or not user_name:
        raise ValueError("Need to provide project name and username or be in a project workarea with 'PROJ_ID' and "
                         "'USER' environemnt variables set.")
    return "{prj}-{user}".format(prj=project_name, user=user_name)


def get_current_user_name():
    """Gets current user's username from 'USER' environment variable."""
    return os.getenv('USER')


def get_current_project_name():
    """Gets current user's username from 'PROJ_ID' environment variable."""
    return os.getenv('PROJ_ID')
