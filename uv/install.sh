#!/bin/sh

# shellcheck disable=SC2034
# "'pkg_cmd_name' appears unused. Verify it or export it."

__init_uv() {

    set -e
    set -u

    ##################
    # Install uv #
    ##################

    # Every package should define these 6 variables
    pkg_no_exec=1
    pkg_cmd_name="uv"

    pkg_dst_cmd="$HOME/.local/bin/uv"
    pkg_dst="$pkg_dst_cmd"

    pkg_src_cmd="$HOME/.local/opt/uv-v$WEBI_VERSION/bin/uv"
    pkg_src_dir="$HOME/.local/opt/uv-v$WEBI_VERSION"
    pkg_src="$pkg_src_cmd"

    ## Make Directory
    mkdir -p "$(dirname "${pkg_src_cmd}")"
    
    ## Injected Variables
    SHELL_INSTALL_URL="https://github.com/astral-sh/uv/releases/download/$WEBI_VERSION/uv-installer.sh"
    UV_NO_MODIFY_PATH=1
    HOME="$pkg_src_dir"
    XDG_BIN_HOME="$pkg_src_dir/bin"
    PRINT_QUIET=1
    
    ## Invoke curlPipe of uv installer
    curl -fsSL "$SHELL_INSTALL_URL" | bash

    test -L "$pkg_dst_cmd" && rm "$pkg_dst_cmd"
    test -L "${pkg_dst_cmd}x" && rm "${pkg_dst_cmd}x"
    ln -s "$pkg_src_cmd" "$pkg_dst_cmd"
    ln -s "${pkg_src_cmd}x" "${pkg_dst_cmd}x"
    
}

__init_uv
