# check_mem_usage
Bash script to return the top 20 processes using memory.  Sorts by usage from high to low.  Also includes swap usage and an overview of system memory.

Output example:

=== TOP 20 PROCESSES BY MEMORY USAGE ===
PID      USER         MEM%     MEM_SIZE     SWAP         COMMAND
27098    sas          11.3%    7.14G        0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
23411    sas          9.3%     5.85G        0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
28748    sas          4.1%     2.58G        0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
22464    sas          0.8%     548.41M      0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
29855    sas          0.6%     409.61M      0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
15724    sas          0.5%     362.34M      8.81M        /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
22381    sas          0.3%     244.52M      0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
22050    sas          0.3%     211.65M      0            /sas94m7/sashome/SASFoundation/9.4/sasexe/sas
22559    sas          0.3%     207.45M      0            /sas94m7/sashome/SASPrivateJavaRuntimeEnvironment/9.4/jre/bin/java
957      root         0.3%     192.70M      1.19M        /usr/lib/systemd/systemd-journald
1961     gdm          0.2%     153.01M      1.72M        /usr/bin/gnome-shell
1546     root         0.1%     97.43M       0            /usr/sbin/rsyslogd
23495    sas          0.1%     80.77M       0            postgres:
23496    sas          0.1%     78.87M       0            postgres:
22213    sas          0.0%     61.88M       0            /sas94m7/sashome/SASFoundation/9.4/sasexe/sas
22004    sas          0.0%     42.45M       0            /sas94m7/sashome/SASWebInfrastructurePlatformDataServer/9.4/bin/postgres
22317    sas          0.0%     33.52M       0            /sas94m7/sashome/SASFoundation/9.4/utilities/bin/objspawn
1331     polkitd      0.0%     30.34M       4.75M        /usr/lib/polkit-1/polkitd
21330    root         0.0%     30.27M       0            /usr/libexec/packagekitd
1599     root         0.0%     28.30M       952K         /usr/sbin/libvirtd

=== SYSTEM MEMORY SUMMARY ===
Total RAM:      62.66 GB
Used RAM:       19.90 GB (31.8%)
Available RAM:  40.35 GB
Total Swap:     7.89 GB
Used Swap:      79.00 MB (1.0%)
