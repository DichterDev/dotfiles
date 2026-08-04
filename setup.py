#!/usr/bin/env python3
import argparse
import subprocess
import sys
from pathlib import Path
import tomllib

# Dynamically locate the dotfiles directory relative to this script
SCRIPT_DIR = Path(__file__).resolve().parent
CONFIG_PATH = SCRIPT_DIR / "config.toml"


def load_config() -> dict:
    if not CONFIG_PATH.exists():
        print(f"Error: {CONFIG_PATH} not found.", file=sys.stderr)
        sys.exit(1)

    with open(CONFIG_PATH, "rb") as f:
        return tomllib.load(f)


def install_packages(pkgs: list[str]):
    if not pkgs:
        print("No packages found to install.")
        return

    print(f"\nInstalling {len(pkgs)} packages: {', '.join(pkgs)}...")
    try:
        subprocess.run(
            ["sudo", "pacman", "-S", "--needed", "--noconfirm", *pkgs],
            check=True,
        )
    except subprocess.CalledProcessError:
        print("Failed to install packages.", file=sys.stderr)


def create_symlink(src: str, dst: str):
    # Resolve relative source paths against the repository root
    source = Path(src)
    if not source.is_absolute():
        source = (SCRIPT_DIR / source).resolve()

    dest = Path(dst).expanduser()

    if not source.exists():
        print(f"  Source {source} does not exist. Skipping.")
        return

    dest.parent.mkdir(parents=True, exist_ok=True)

    if dest.exists() or dest.is_symlink():
        if dest.is_symlink():
            print(f"  Removing existing symlink at {dest}")
            dest.unlink()
        else:
            print(
                f"  Target {dest} exists and is a real file/directory. Skipping to prevent data loss."
            )
            return

    dest.symlink_to(source)
    print(f"  Symlink created: {dest} -> {source}")


def enable_service(name: str, service_def: str):
    """Enables a systemd service.

    Handles '--user mpd.service' or simple 'docker.service' formats.
    """
    parts = service_def.split()
    is_user = "--user" in parts

    service_args = [p for p in parts if p != "--user"]

    cmd = ["systemctl"]
    if is_user:
        cmd.append("--user")
    else:
        cmd.insert(0, "sudo")

    cmd.extend(["enable", "--now", *service_args])

    print(f"Enabling service '{name}' ({'user' if is_user else 'system'})...")
    try:
        subprocess.run(cmd, check=True)
        print(f"  Successfully enabled service: {name}")
    except subprocess.CalledProcessError:
        print(f"  Failed to enable service: {name}", file=sys.stderr)


def process_home_links(home_config: dict):
    """Recursively traverses the [home] section to map subpaths to ~/.X paths."""
    print("\nProcessing home symlinks...")

    HIDDEN_TOP_LEVELS = {"config", "local", "cache"}

    def _traverse(node: dict, current_subpath: Path, is_root: bool = False):
        for key, val in node.items():
            if is_root and key in HIDDEN_TOP_LEVELS:
                segment_name = f".{key}"
            else:
                segment_name = key

            next_subpath = current_subpath / segment_name

            if isinstance(val, dict):
                _traverse(val, next_subpath, is_root=False)
            elif isinstance(val, str):
                dst = Path.home() / next_subpath
                create_symlink(val, str(dst))

    _traverse(home_config, Path(), is_root=True)


def action_install(config: dict):
    """Installs packages defined in config.toml."""
    pkgs = config.get("pkgs", [])
    install_packages(pkgs)


def action_link(config: dict):
    """Creates symlinks defined in the [home] tables."""
    home_section = config.get("home", {})
    if home_section:
        process_home_links(home_section)


def action_services(config: dict):
    """Enables systemd services defined in [services]."""
    services = config.get("services", {})
    if not services:
        print("\nNo services defined in config.")
        return

    print(f"\nEnabling {len(services)} services...")
    for name, srv_def in services.items():
        enable_service(name, srv_def)


def action_setup(config: dict):
    """Runs full setup: package installation, linking, and enabling services."""
    action_install(config)
    action_link(config)
    action_services(config)


def main():
    parser = argparse.ArgumentParser(
        description="Dotfiles & system setup script",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    subparsers = parser.add_subparsers(dest="command", help="Available commands")

    # Subcommands
    subparsers.add_parser(
        "setup", help="Full setup (install + links + services) [Default]"
    )
    subparsers.add_parser("install", help="Install packages only")
    subparsers.add_parser("link", help="Create symlinks only")
    subparsers.add_parser("services", help="Enable systemd services only")

    args = parser.parse_args()

    command = args.command or "setup"
    config = load_config()

    if command == "install":
        action_install(config)
    elif command == "link":
        action_link(config)
    elif command == "services":
        action_services(config)
    elif command == "setup":
        action_setup(config)


if __name__ == "__main__":
    main()
