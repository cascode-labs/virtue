import pluggy
from virtue.plugins import lib, hookspecs

def get_plugin_manager():
    pm = pluggy.PluginManager("virtue")
    pm.add_hookspecs(hookspecs)
    pm.load_setuptools_entrypoints("virtue")
    pm.register(lib)
    return pm

plugin_manager = get_plugin_manager()
