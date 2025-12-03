#!/bin/bash

echo = "🔍️ Searching for file ..."
file="$1"

if test -f "$file"; then
    echo "✅️ 📄 File $file found."
    chmod u+x "$file"
    echo "✅️ Access set for user."
    chmod go-rwx "$file"
    echo "✅️ Access remove for other groups and other users."
    echo "⚙️ Loading script ..."
    ./"$file"
    echo "✅️ Program done."
else
    echo "❌️ 📄 File $file not found."
fi
