rm(list = ls())
library(tictoc)

size <- 50
simulations <- 1000
meanVec <- numeric(simulations)
sdVec <- numeric(simulations)
veces <- 2
tic()
for (i in 1:simulations) {
     simul <- rexp(size, 0.2)
     meanVec[i] <- mean(simul)
     sdVec[i] <- sd(simul)
}
toc()
f <- abs((meanVec-1/0.2))> veces*(1/(0.2*sqrt(size))) #Factor vector
windows(title = "PLOT")
par(mfrow = c(2,1))
hist(meanVec, 31)
abline(v = 1/0.2 + veces*c(-1,1)/(0.2*sqrt(size)), col = 'red', lwd = 3)
abline(v = 1/0.2, lwd = 3 , col = 'blue')
plot(meanVec, col = factor(f))
abline(h = 1/0.2, lwd = 3 , col = 'blue')
abline(h = 1/0.2 + veces*c(-1,1)/(0.2*sqrt(size)), lwd = 3,
       col = 'red')
#dev.off()
