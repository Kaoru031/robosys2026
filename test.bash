#!/bin/bash
# SPDX-FileCopyrightText: 2026 Kaoru Kitaya
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo ${1}行目のテスト失敗
    res=1
}

res=0

### NORMAL INPUT ###
out=$(seq 5 | ./stats)
[ "$?" = 0 ]               || ng "$LINENO"
[ "${out}" = "5 15 3 1 5" ] || ng "$LINENO"

out=$(seq 5 | ./stats --count)
[ "$?" = 0 ]     || ng "$LINENO"
[ "${out}" = "5" ] || ng "$LINENO"

out=$(seq 5 | ./stats --sum)
[ "$?" = 0 ]      || ng "$LINENO"
[ "${out}" = "15" ] || ng "$LINENO"

out=$(seq 5 | ./stats --mean)
[ "$?" = 0 ]     || ng "$LINENO"
[ "${out}" = "3" ] || ng "$LINENO"

out=$(seq 5 | ./stats --min)
[ "$?" = 0 ]     || ng "$LINENO"
[ "${out}" = "1" ] || ng "$LINENO"

out=$(seq 5 | ./stats --max)
[ "$?" = 0 ]     || ng "$LINENO"
[ "${out}" = "5" ] || ng "$LINENO"

out=$(printf "1.5\n2.5\n" | ./stats --sum)
[ "$?" = 0 ]     || ng "$LINENO"
[ "${out}" = "4" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo abc | ./stats 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo -n "" | ./stats 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo | ./stats 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(seq 5 | ./stats --unknown 2>/dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
