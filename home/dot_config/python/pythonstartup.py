# https://github.com/python/cpython/blob/b9cdd0fb9c463c2503a4d854bb6529a9db58fe1b/Lib/site.py#L470-L491
# https://gist.github.com/viliampucik/8713b09ff7e4d984b29bfcd7804dc1f4
# Store interactive Python shell history in ~/.local/state/python/history
# instead of ~/.python_history.
#
# Create the following .config/python/pythonstartup.py file
# and export its path using PYTHONSTARTUP environment variable:
# export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonstartup.py"

import atexit
import os
from pathlib import Path
import readline

histfile = Path(
    os.getenv(
        "XDG_STATE_HOME",
        os.getenv("XDG_DATA_HOME", os.path.expandvars("$HOME/.local/share"))
    ),
    "python",
    "history",
)
if not histfile.parent.is_dir():
    histfile.parent.mkdir(parents=True)

# override because site.py calls write_history_file with hard-coding path
write_history_file  = readline.write_history_file 
def override_write_history_file(*args, **kwargs):
    return write_history_file(histfile)
readline.write_history_file = override_write_history_file

try:
    readline.read_history_file(histfile)
    # default history len is -1 (infinite), which may grow unruly
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
