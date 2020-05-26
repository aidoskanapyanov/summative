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
####################################################




data <- read_csv("data/MIE.csv")

make_LD <- function(x){
    structure(list(id = x[1], visit = x[2], room = x[3],
                   value = x[4], timepoint = x[5]), class = "LongitudinalData")
}

print.LongitudinalData <- function(x){
    print(paste("Longitudinal dataset with", nrow(unique(x$id)),"subjects"))
}

subject.LongitudinalData <- function(object, id) {
    
}

x <- make_LD(data)
print(class(x))
print(x)

## Subject 10 doesn't exist
out <- subject(x, 10)
print(out)