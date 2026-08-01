import subprocess
import sys
from pathlib import Path

import tomllib


def install_package(name: str):
    print(f"\nInstalling {name}...")
    try:
        subprocess.run(
            ["sudo", "pacman", "-S", "--needed", "--noconfirm", name], check=True
        )
    except subprocess.CalledProcessError:
        print(f"Failed to install {name}.", file=sys.stderr)


def create_symlink(src: str, dst: str):
    source = Path(src).resolve()
    dest = Path(dst).expanduser()

    print(f"Linking {dest.name}...")

    if not source.exists():
        print(f"Source {source} does not exist. Skipping.")
        return

    dest.parent.mkdir(parents=True, exist_ok=True)

    if dest.exists() or dest.is_symlink():
        if dest.is_symlink():
            print(f"Removing existing symlink at {dest}")
            dest.unlink()
        else:
            print(
                f"Target {dest} exists and is a real file/directory. Skipping to prevent data loss."
            )
            return

    dest.symlink_to(source)
    print(f"Symlink created: {dest} -> {source}")


def enable_service(srv: str):
    print(f"Enabling service: {srv}")
    args = srv.split()

    cmd = ["sudo systemctl"] if "--user" not in args else ["systemctl"]

    if "--user" in args:
        args.remove("--user")
        cmd.append("--user")

    cmd.extend(["enable", "--now"])
    cmd.extend(args)

    try:
        subprocess.run(cmd, check=True)
        print(f"Enabled service: {srv}")
    except subprocess.CalledProcessError:
        print(f"Failed to enable service: {srv}")


def main():
    config_file = Path("config.toml")

    if not config_file.exists():
        print("config.toml not found in the current directory.")
        sys.exit(1)

    with open(config_file, "rb") as f:
        config = tomllib.load(f)

    pkgs = config.get("pkgs", [])

    print(f"Found {len(pkgs)} packages in config.")

    for pkg in pkgs:
        if "name" in pkg:
            install_package(pkg["name"])

        if "config" in pkg and "link" in pkg:
            create_symlink(pkg["config"], pkg["link"])

        if "service" in pkg:
            enable_service(pkg["service"])

    links = config.get("links", [])

    print(f"Found {len(links)} links in config.")

    for link in links:
        if "src" in link and "dst" in link:
            create_symlink(link["src"], link["dst"])


if __name__ == "__main__":
    main()
