import os
from cli import command_exists

class runner(object):
    """Runner for Docker container"""

    def __init__(self, image, container_dir, host_volume_dir):
        """Initialize image and directory for container"""

        if not command_exists("docker"):
            raise Exception('docker cannot be executed')

        if not os.path.isdir(host_volume_dir):
            raise Exception('Directory ' + host_volume_dir + ' does not exist')

        self.image = image
        self.container_dir = container_dir
        self.host_volume_dir = os.path.abspath(host_volume_dir)
        self.host_working_dir = None
        self.command = None

    @property
    def command(self):
        return self.container_command

    @command.setter
    def command(self, command):
        self.container_command = command

    @property
    def working_dir(self):
        return self.host_working_dir

    @working_dir.setter
    def working_dir(self, working_dir):
        self.host_working_dir = os.path.abspath(working_dir)

    def run(self, container_arguments):
        cli_command = [
            "docker",
            "run",
            "-v", self.host_volume_dir + ":" + self.container_dir
        ]
        if self.working_dir is not None:
            cli_command += [
                "-w", self.working_dir
            ]

        cli_command += [
            self.image
        ]
        if self.command is not None:
            cli_command += [
                self.command
            ]
        cli_command += container_arguments

        os.system(" ".join(cli_command))
