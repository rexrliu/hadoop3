# .bashrc

alias ls="ls --color=auto"
LS_COLORS='di=1;33:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias ll="ls -l"
alias la="ls -lGa"

alias hvb="beeline -u jdbc:hive2://localhost:10000/default"
alias spy="spark-shell --deploy-mode client --master yarn"

# Common Hadoop File System Aliases
alias hf="hadoop fs"                                         # Base Hadoop fs command
alias hfcat="hf -cat"                                        # Output a file to standard out
alias hfchgrp="hf -chgrp"                                    # Change group association of files
alias hfchmod="hf -chmod"                                    # Change permissions
alias hfchown="hf -chown"                                    # Change ownership
alias hfcfl="hf -copyFromLocal"                              # Copy a local file reference to HDFS
alias hfctl="hf -copyToLocal"                                # Copy a HDFS file reference to local
alias hfcp="hf -cp"                                          # Copy files from source to destination
alias hfdu="hf -du -h"                                       # Display aggregate length of files
alias hfdus="hf -dus -h"                                     # Display a summary of file lengths
alias hfget="hf -get"                                        # Get a file from hadoop to local
alias hfgetm="hf -getmerge"                                  # Get files from hadoop to a local file
alias hfls="hf -ls"                                          # List files
alias hfll="hf -lsr"                                         # List files recursivly
alias hfmkdir="hf -mkdir"                                    # Make a directory
alias hfmv="hf -mv"                                          # Move a file
alias hfput="hf -put"                                        # Put a file from local to hadoop
alias hfrm="hf -rm"                                          # Remove a file
alias hfrmr="hf -rmr"                                        # Remove a file recursivly
alias hfsr="hf -setrep"                                      # Set the replication factor of a file
alias hfstat="hf -stat"                                      # Returns the stat information on the path
alias hftail="hf -tail"                                      # Tail a file
alias hftest="hf -test"                                      # Run a series of file tests. See options
alias hftouch="hf -touchz"                                   # Create a file of zero length

# Convenient Hadoop File System Aliases
alias hfet="hf -rmr .Trash"                                  # Remove/Empty the trash
function hfdub() {                                           # Display aggregate size of files descending
   hadoop fs -du "$@" | sort -k 1 -n -r
}

# Common Hadoop Job Commands
alias hj="hadoop job"                                        # Base Hadoop job command
alias hjstat="hj -status"                                    # Print completion percentage and all job counters
alias hjkill="hj -kill"                                      # Kills the job
alias hjhist="hj -history"                                   # Prints job details, failed and killed tip details
alias hjls="hj -list"                                        # List jobs
alias myhj="hjls | grep 'rong'"                              # List my jobs only

# Common Hadoop DFS Admin Commands
alias habal="hadoop balancer"                                # Runs a cluster balancing utility
alias harep="hadoop dfsadmin -report"                        # Print the hdfs admin report

#Common Yarn Application Aliases/Functions
alias yn="yarn application"                                  # yarn application
alias ynls="yn -list"                                        # List yarn application jobs
alias ynkill="yn -kill"                                      # List yarn application jobs

# PATH and CLASSPATH
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar

# export PS1
export PS1="\[\033[1;36m\][\u@Hadoop3:\W]$\[\033[0m\] "
