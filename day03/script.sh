#!bin/bash

file="$1"

chmod u+x "$file"

chmod go-rwx "$file"

./"$file"
