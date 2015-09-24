#!/usr/bin/Rscript
heisenberg <- read.csv(file="./.rep/stats.csv",head=TRUE,sep=",")
plot(heisenberg$Execution_Time,type="l",xlab="Unrolling Depth",ylab="Time in uSecs")
