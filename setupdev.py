#!/usr/bin/env python

import sys, subprocess, json, os, re, time
import fire
import rich
from rich import print

ALACRITTY_CLASS = "Alacritty"


class Commands:
    def __init__(self):
        self.set_workspace()

    def get_ram_percentage(self):
        # Execute the 'free' command to get memory usage details
        result = subprocess.run(['free', '-b'], stdout=subprocess.PIPE)
        # Decode the result to get a string
        output = result.stdout.decode('utf-8')

        # Split the output into lines
        lines = output.split('\n')
        
        # Find the line that starts with 'Mem:'
        mem_line = next(line for line in lines if line.startswith('Mem:'))

        # Split the line into fields and extract total and used memory
        fields = mem_line.split()
        total_memory = int(fields[1])
        used_memory = int(fields[2])

        # Calculate the percentage of used memory
        used_percentage = used_memory / total_memory

        return used_percentage

    def set_workspace(self):
        raw_workspace = self.run("hyprctl activeworkspace")
        self.workspace = int(raw_workspace.split("\n")[0].split(" ")[2])
        self.delay = 2*self.get_ram_percentage()
        # self.notify(self.delay)

    def run(self, cmd: str, delay=0) -> str:
        print(cmd)
        output = subprocess.run(cmd.split(), capture_output=True).stdout.decode("utf-8")
        if delay: time.sleep(delay)
        return output

    def notify(self, message: str, color="rgb(ffffff)", timeout=5000):
        """Notify"""
        self.run(f"hyprctl notify -1 {timeout} {color} {message}")

    def get_windows(self):
        clients = self.run("hyprctl -j clients")
        # window_class = sys.argv[1]
        return json.loads(clients)

    def setupdev(self):
        windows = self.get_windows()
        addresses = list(map(lambda w: w["address"], windows))

        # matched_windows = []
        # for window in windows:
        #     if window["class"] == WINDOW_CLASS:
        #         matched_windows.append(window)

        self.run("hyprctl dispatch exec alacritty")

        # # print(windows)
        # for window in matched_windows:
        #     print(window)
        # json.print(windows)

        new_windows = self.get_windows()

        for window in new_windows:
            if not (window["address"] in addresses):
                break

        print(window)

        clients = run("hyprctl -j clients")

    def workspace(self):
        """Return active workspace"""
        print(self.workspace)

    def windows(self):
        """Return all windows"""
        print(self.get_windows())

    def workspace_windows(self):
        """Return workspace windows"""
        print(self.get_workspace_windows())

    def get_workspace_windows(self, workspace: int):
        """Return all windows in given workspace"""
        windows = self.get_windows()
        workspace_windows = []
        for window in windows:
            if int(window["workspace"]["id"]) == workspace:
                workspace_windows.append(window)
        return workspace_windows

    # def setup_dev_workspace(self, workspace: int):

    def setup_neovim(self, windows: dict):
        nvim_windows = self.get_windows_from_process(windows, "nvim")
        if len(nvim_windows) == 0:
            open_nvim_cmd = "hyprctl dispatch exec".split() + ["alacritty -e nvim --listen /tmp/nvim"]
            print(open_nvim_cmd)
            subprocess.run(open_nvim_cmd, capture_output=True).stdout.decode("utf-8")
            time.sleep(self.delay*2)
            workspace_windows = self.get_workspace_windows(self.workspace)
            nvim_windows = self.get_windows_from_process(workspace_windows, "nvim")
        return nvim_windows

    def setup_workspace(self):
        """Setup active workspace"""
        workspace_windows = self.get_workspace_windows(self.workspace)
        alacritty_windows = []
        other_windows = []
        for window in workspace_windows:
            if window["class"] == ALACRITTY_CLASS:
                alacritty_windows.append(window)
            else:
                other_windows.append(window)

        nvim_windows = self.setup_neovim(alacritty_windows)
        shell_windows = self.get_the_rest(alacritty_windows, nvim_windows)
        print(shell_windows)

        nvim_window = nvim_windows[0]
        # shell_window = shell_windows[0]

        self.dispatch_dev_workspace(nvim_window, shell_windows, other_windows)

    def get_the_rest(self, all, remove):
        rest = []
        for item in all:
            if not item in remove:
                rest.append(item)
        return rest

    def get_windows_from_process(self, windows: dict, process_name: str):
        matches = []
        for window in windows:
            pid = window["pid"]
            pstree_output = self.run(f"pstree -p {pid}")
            if process_name in pstree_output:
                matches.append(window)
        return matches

    # def get_process(self, address):
    #     windows = self.get_windows()
    #     for window in windows:
    #         if window["address"] == address and window["class"] == ALACRITTY_CLASS:
    #             pid = window["pid"]
    #             break
    #     else:
    #         return

    #     pstree_output = self.run(f"pstree -p {pid}")
    #     line = pstree_output.splitlines()[0]
    #     line = re.sub(r"[+-]", " ", line).split()
    #     process = line[2]
    #     print(address, pid, process)
    #     if

    def focus(self, window: dict):
        addr = window["address"]
        self.run(f"hyprctl dispatch focuswindow address:{addr}")

    def set_in_floating(self, window: dict):
        floating = bool(window["floating"])
        if not floating:
            self.focus(window)
            self.run(f"hyprctl dispatch togglefloating")

    def get_process_id(self, window: dict, process_name: str):
        pid = window["pid"]
        pstree = self.run(f"pstree -p {pid}")
        line = pstree.splitlines()[0]
        raw_processes = re.sub(r"[+-]", " ", line)
        raw_processes = re.sub(r"[(){}]", " ", raw_processes).split()
        processes = []
        for i in range(len(raw_processes) // 2):
            process = (raw_processes[2 * i], int(raw_processes[2 * i + 1]))
            processes.append(process)
        for process in processes:
            if process[0] == process_name:
                print(process[1])
                return process[1]
        return

    def run_for_each(self, windows: list, cmd: str):
        for window in windows:
            self.focus(window)
            self.run(cmd)

    def spawn_nvim_subprocess(self, cmd: str, delay=0):
        nvim_remote_send = "nvim --server /tmp/nvim --remote-send".split()
        nvim_cmd = nvim_remote_send + [cmd]
        subprocess.run(nvim_cmd, capture_output=True).stdout.decode("utf-8")
        if delay: time.sleep(delay)

    def dispatch_dev_workspace(
            self, editor_window: dict, shell_windows: list, other_windows: list
    ):
        self.notify("dev workspace setup")
        self.run_for_each(shell_windows, "hyprctl dispatch killactive")

        pid = self.get_process_id(editor_window, "nvim")
        cwd = os.readlink(f"/proc/{pid}/cwd")
        cwd = self.get_directory_containing(cwd, "Makefile")

        windows = other_windows + [editor_window]
        for window in windows:
            self.set_in_floating(window)

        self.run("hyprctl dispatch hy3:makegroup h")
        self.run_for_each(windows, "hyprctl dispatch togglefloating")

        self.focus(editor_window)
        self.run("hyprctl dispatch hy3:makegroup v")

        self.spawn_nvim_subprocess(f":call jobstart(['alacritty', '--working-directory', '{cwd}'])<CR>", delay=self.delay)
        # self.spawn_nvim_subprocess(f":call jobstart(['alacritty'])<CR>")

        # windows = self.get_workspace_windows(self.workspace)
        # shell_windows = self.get_the_rest(
        #     windows, [editor_window] + list(other_windows)
        # )
        # shell_window = shell_windows[0]
        # self.notify(shell_window)

        self.focus(editor_window)
        width, height = 135, 310
        # self.notify(f"{width}, {height}")
        self.run(f"hyprctl dispatch resizeactive {width} {height}")

    def get_directory_containing(self, directory: str, searched_node: str):
        """Return directory containing a node. Useful to get .git directory"""
        # print(directory, searched_node)
        files = self.run(f"ls -a {directory}").split()
        # print(files)
        if directory == "":
            return directory
        elif searched_node in files:
            return directory
        else:
            parent_directory = "/".join(directory.split("/")[:-1])
            # print(parent_directory)
            return self.get_directory_containing(parent_directory, searched_node)

    def shell(self):
        self.run("alacritty --working-directory /home/marc/git")


if __name__ == "__main__":
    fire.Fire(Commands)
