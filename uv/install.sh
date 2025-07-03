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
    pkg_cmd_name="uv"

    pkg_dst_cmd="$HOME/.local/bin/uv"
    pkg_dst="$pkg_dst_cmd"

    pkg_src_cmd="$HOME/.local/opt/uv-v$WEBI_VERSION/bin/uv"
    pkg_src_dir="$HOME/.local/opt/uv-v$WEBI_VERSION"
    pkg_src="$pkg_src_cmd"

    # pkg_install must be defined by every package
    pkg_install() {
        mkdir -p "$(dirname "${pkg_src_cmd}")"
        mv ./uv-*/uv* "$(dirname "${pkg_src_cmd}")"
    }

    pkg_link() {
        ln -s "$pkg_src_cmd" "$pkg_dst_cmd"
        printf "    Linking: ${pkg_src_cmd} -> ${pkg_dst_cmd}\n"
        printf "    Linking: ${pkg_src_cmd}x -> ${pkg_dst_cmd}x\n"
        ln -s "${pkg_src_cmd}x" "${pkg_dst_cmd}x"
    }


    pkg_get_current_version() {
        # 'uv --version' has output in this format:
        #       uv 0.99.9 (rev abcdef0123)
        # This trims it down to just the version number:
        #       0.99.9
        uv --version 2> /dev/null |
            head -n 1 |
            cut -d ' ' -f 2
    }

}

__init_uv
