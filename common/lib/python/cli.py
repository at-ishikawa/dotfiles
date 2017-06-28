from shutil import which

def command_exists(command):
    """Check if executable `command` is on PATH"""
    return which(command) is not None
