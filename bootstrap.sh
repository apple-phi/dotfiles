#!/bin/sh

# Credit to https://github.com/chezmoi/dotfiles/blob/master/install.sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# Log the current directory and list files
echo "Current directory: $(pwd)"
echo "Listing files:"
ls -la

# Verify if chezmoi is installed or install it
if ! chezmoi="$(command -v chezmoi)"; then
        bin_dir="${HOME}/.local/bin"
        chezmoi="${bin_dir}/chezmoi"
        echo "Installing chezmoi to '${chezmoi}'" >&2
        if command -v curl >/dev/null; then
                chezmoi_install_script="$(curl -fsSL get.chezmoi.io)"
        elif command -v wget >/dev/null; then
                chezmoi_install_script="$(wget -qO- get.chezmoi.io)"
        else
                echo "To install chezmoi, you must have curl or wget installed." >&2
                exit 1
        fi
        sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
        unset chezmoi_install_script bin_dir
fi

# Log the installation result
echo "chezmoi installed at: $(command -v chezmoi)"
chezmoi --version

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# Log the script directory
echo "Script directory: ${script_dir}"

# Set arguments for chezmoi init
set -- init --apply --source="${script_dir}"

# Log the command to be executed
echo "Running 'chezmoi $*'" >&2

# Debug: List files in the script directory and .chezmoiscripts directory
echo "Listing files in ${script_dir}:"
ls -al "${script_dir}"

echo "Listing files in ${script_dir}/.chezmoiscripts:"
ls -al "${script_dir}/.chezmoiscripts"

# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
