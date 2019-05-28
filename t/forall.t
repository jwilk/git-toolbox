#!/bin/sh

# Copyright © 2019 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
base="${0%/*}/.."
if ! [ -d "$base/.git" ]
then
    echo 1..0 '# skip not git checkout'
    exit 0
fi
echo 1..1
tmplog=$(mktemp -t git-toolbox.XXXXXX)
"$base/git-forall" status >"$tmplog"
sed -e 's/^/# /' "$tmplog"
echo ok 1
rm "$tmplog"

# vim:ts=4 sts=4 sw=4 et ft=sh
