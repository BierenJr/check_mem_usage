#!/bin/bash

# Get process info sorted by memory usage
echo ""
echo "=== TOP 20 PROCESSES BY MEMORY USAGE ==="

ps aux --sort=-%mem | head -n 21 | awk 'NR==1 {
    printf "%-8s %-12s %-8s %-12s %-12s %s\n", "PID", "USER", "MEM%", "MEM_SIZE", "SWAP", "COMMAND"
    next
} {
    pid=$2
    user=$1
    mem_pct=$4
    vsz=$5
    rss=$6
    cmd=$11
    
    # Convert RSS (resident memory) from KB to human readable
    if (rss >= 1048576) {
        mem_size = sprintf("%.2fG", rss/1048576)
    } else if (rss >= 1024) {
        mem_size = sprintf("%.2fM", rss/1024)
    } else {
        mem_size = sprintf("%dK", rss)
    }
    
    # Get swap usage for this process
    swap_file = "/proc/" pid "/status"
    swap = 0
    while ((getline < swap_file) > 0) {
        if ($1 == "VmSwap:") {
            swap = $2
            break
        }
    }
    close(swap_file)
    
    # Convert swap from KB to human readable
    if (swap >= 1048576) {
        swap_size = sprintf("%.2fG", swap/1048576)
    } else if (swap >= 1024) {
        swap_size = sprintf("%.2fM", swap/1024)
    } else if (swap > 0) {
        swap_size = sprintf("%dK", swap)
    } else {
        swap_size = "0"
    }
    
    printf "%-8s %-12s %-8s %-12s %-12s %s\n", pid, user, mem_pct"%", mem_size, swap_size, cmd
}'

echo ""
echo "=== SYSTEM MEMORY SUMMARY ==="

# Get memory info from /proc/meminfo
awk '
BEGIN {
    total_ram = 0
    free_ram = 0
    available_ram = 0
    buffers = 0
    cached = 0
    total_swap = 0
    free_swap = 0
}
/^MemTotal:/ { total_ram = $2 }
/^MemFree:/ { free_ram = $2 }
/^MemAvailable:/ { available_ram = $2 }
/^Buffers:/ { buffers = $2 }
/^Cached:/ { cached = $2 }
/^SwapTotal:/ { total_swap = $2 }
/^SwapFree:/ { free_swap = $2 }
END {
    used_ram = total_ram - free_ram - buffers - cached
    used_swap = total_swap - free_swap
    
    # Convert to human readable
    if (total_ram >= 1048576) {
        total_ram_str = sprintf("%.2f GB", total_ram/1048576)
    } else {
        total_ram_str = sprintf("%.2f MB", total_ram/1024)
    }
    
    if (used_ram >= 1048576) {
        used_ram_str = sprintf("%.2f GB", used_ram/1048576)
    } else {
        used_ram_str = sprintf("%.2f MB", used_ram/1024)
    }
    
    if (available_ram >= 1048576) {
        available_ram_str = sprintf("%.2f GB", available_ram/1048576)
    } else {
        available_ram_str = sprintf("%.2f MB", available_ram/1024)
    }
    
    if (total_swap >= 1048576) {
        total_swap_str = sprintf("%.2f GB", total_swap/1048576)
    } else {
        total_swap_str = sprintf("%.2f MB", total_swap/1024)
    }
    
    if (used_swap >= 1048576) {
        used_swap_str = sprintf("%.2f GB", used_swap/1048576)
    } else {
        used_swap_str = sprintf("%.2f MB", used_swap/1024)
    }
    
    ram_used_pct = (used_ram / total_ram) * 100
    swap_used_pct = total_swap > 0 ? (used_swap / total_swap) * 100 : 0
    
    printf "Total RAM:      %s\n", total_ram_str
    printf "Used RAM:       %s (%.1f%%)\n", used_ram_str, ram_used_pct
    printf "Available RAM:  %s\n", available_ram_str
    printf "Total Swap:     %s\n", total_swap_str
    printf "Used Swap:      %s (%.1f%%)\n", used_swap_str, swap_used_pct
}
' /proc/meminfo

echo ""