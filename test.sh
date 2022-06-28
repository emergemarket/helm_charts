#!/bin/bash

first_loop=1
for file in ${{ steps.file-list.outputs.all_changed_and_modified_files }}; do
value=$(basename $(dirname $file | sed -E 's|.*/charts/charts/(.*)|\1|'))
(( $first_loop )) &&
var=$value ||
var="$var\n$value"
unset first_loop
done
echo "$(printf "%s" "$var" | jq -Rrsc 'split("\\n") | unique')"
echo "::set-output name=matrix::$(printf "%s" "$var" | jq -Rrsc 'split("\\n") | unique')"