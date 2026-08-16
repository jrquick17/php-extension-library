#!/usr/bin/env bash

# Source populate.sh to get access to versions, pcntl, and redis functions
source "$(dirname "$0")/populate.sh"

# If arguments are passed, use them as the target versions.
# Otherwise, check all versions from the populate.sh versions list.
if [ $# -gt 0 ]; then
    target_versions=("$@")
else
    target_versions=("${versions[@]}")
fi

echo "Checking for missing PHP version directories..."

missing_count=0
for i in "${target_versions[@]}"; do
    # A version is considered missing if its directory doesn't exist 
    # or if the directory contains no pre-compiled .so extensions.
    if [ ! -d "php$i" ] || [ -z "$(find "php$i" -maxdepth 1 -name '*.so' 2>/dev/null)" ]; then
        echo "--> PHP $i is missing. Compiling extensions..."
        if [ ! -d "php$i" ]; then
            mkdir "php$i"
        fi

        if [ ! -f "php$i/pcntl.so" ]; then
            pcntl "$i"
        fi

        if [ ! -f "php$i/redis.so" ]; then
            redis "$i"
        fi
        missing_count=$((missing_count + 1))
    fi
done

if [ $missing_count -eq 0 ]; then
    echo "No missing PHP version directories found."
else
    echo "Successfully compiled extensions for $missing_count missing PHP version(s)."
fi

# Clean up temp files if any compilation occurred
if [ $missing_count -gt 0 ]; then
    rm -rf php-*
    rm -rf phpredis-*
fi
