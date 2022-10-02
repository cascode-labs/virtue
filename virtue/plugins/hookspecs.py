import pluggy
from virtue.skill_package.metadata_data import SKillPackageMetadata

hookspec = pluggy.HookspecMarker("virtue")


@hookspec
def virtue_register_skill_package() -> SKillPackageMetadata: # type: ignore
    """ Registers a skill package with Virtue.

    The skill package will be loaded in Virtue's skill environment.

    returns:
        A dict containing the required package metadata keys from the
        SKillPackageMetadata TypedDict and, optionally, any of the
        keys from SKillPackageOptionalMetadata TypedDict.
    """
