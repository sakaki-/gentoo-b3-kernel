#!/bin/bash
#
# Simple script to tweak an existing baseline kernel .config file.
#
# Copyright (c) 2018-19 sakaki <sakaki@deciban.com>
# License: GPL v2.0
# NO WARRANTY
#

set -e
set -u
shopt -s nullglob

# Utility functions

set_kernel_config() {
    # flag as $1, value to set as $2, config must exist at "./.config"
    local TGT="CONFIG_${1#CONFIG_}"
    local REP="${2//\//\\/}"
    if grep -q "^${TGT}[^_]" .config; then
        sed -i "s/^\(${TGT}=.*\|# ${TGT} is not set\)/${TGT}=${REP}/" .config
    else
        echo "${TGT}=${2}" >> .config
    fi
}

unset_kernel_config() {
    # unsets flag with the value of $1, config must exist at "./.config"
    local TGT="CONFIG_${1#CONFIG_}"
    sed -i "s/^${TGT}=.*/# ${TGT} is not set/" .config
}


# Custom config settings follow

# Submit PRs with edits targeting the _bottom_ of this file
# Please set modules where possible, rather than building in, and
# provide a short rationale comment for the changes made

# Enable seccomp for hardening etc.
set_kernel_config CONFIG_SECCOMP y
set_kernel_config CONFIG_SECCOMP_FILTER y

