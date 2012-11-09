#!/bin/sh
#
# Copyright (c) 2011 András Veres-Szentkirályi
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

GL=$(git log --pretty=format:"%s" --abbrev-commit $*)

if [ $? -ne 0 ]; then
	echo "Git error occured: $GL" 1>&2
	exit 1
fi

DIR=$(dirname $0)
BASE=$(git config rgdm.base)
KEY=$(git config rgdm.key)

(
	echo '<?xml version="1.0" encoding="utf-8"?><fakeroot>'
	echo "$GL" | egrep -o '#[0-9]+' | sort -u | tr -d '#' | while read ISSUE; do
			curl --silent "$BASE/issues/$ISSUE.xml?key=$KEY&include=journals" \
				| xsltproc "$DIR/notes.xsl" -
	done
	echo '</fakeroot>'
) | xsltproc "$DIR/sql.xsl" -
