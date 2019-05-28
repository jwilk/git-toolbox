#!/bin/sh

# Copyright © 2019 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

base="${0%/*}/.."
if [ -d "$base/.git" ]
then
    git_dir=$(git -C "$base" rev-parse --show-toplevel)
    url="file://$git_dir"
else
    echo 1..0 '# skip not git checkout'
    exit 0
fi
echo 1..3
tmpdir=$(mktemp -d -t git-toolbox.XXXXXX)
"$base/git-mktar" -o "$tmpdir/git-toolbox.git.tar" "$url"
echo ok 1
"$base/git-untar" -o "$tmpdir/git-toolbox" "$tmpdir/git-toolbox.git.tar"
echo ok 2
git -C "$tmpdir/git-toolbox" fsck
echo ok 3
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
