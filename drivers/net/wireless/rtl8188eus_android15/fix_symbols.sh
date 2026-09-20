#!/bin/bash

# Backup
for file in $(grep -l "kernel_read\|filp_open" *.c os_dep/linux/*.c 2>/dev/null); do
    echo "Fixing $file"
    cp "$file" "${file}.backup"
    
    # Option A: Comment out problematic lines (temporary)
    # sed -i 's/kernel_read/\/\/ kernel_read/g' "$file"
    # sed -i 's/filp_open/\/\/ filp_open/g' "$file"
    
    # Option B: Replace with proper kernel 5.15 API
    # Note: You need to check the actual usage context
    sed -i 's/kernel_read/kernel_read_file/g' "$file" 2>/dev/null
done

# Check if there's a .mod.c file that needs fixing
find . -name "*.mod.c" -exec grep -l "kernel_read\|filp_open" {} \;
