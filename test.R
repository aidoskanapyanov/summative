source("Factorial_loop.R")
Factorial_loop(13)

source("Factorial_reduce.R")
Factorial_reduce(13)

source("Factorial_func.R")
Factorial_func(13)

source("Factorial_mem.R")
Factorial_mem(13)

fac_tbl <<- c(1,rep(NA,20))
library(microbenchmark)
microbenchmark(loop <- Factorial_loop(20), 
               reduce <- Factorial_reduce(20),
               func <- Factorial_func(20),
               memo <- Factorial_mem(20))
