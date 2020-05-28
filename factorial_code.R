Factorial_loop = function(n){
    answer = 1
    for (i in seq(n)) {
        answer = answer*i
    }
    return(answer)
}

Factorial_reduce = function(n){
    numeric(n)
    require(purrr)
    sequence = seq(n)
    reduce(sequence, function(x,y) as.numeric(x)*as.numeric(y))
}

Factorial_func = function(n){
    if (n == 1) {
        1
    }else{
        Factorial_func(n-1)*n
    }
}

Factorial_mem = function(n){
    if(!is.na(fac_tbl[n])){
        fac_tbl[n]
    } else {
        fac_tbl[n] <<- Factorial_mem(n-1)*n
        fac_tbl[n]
    }
}

fac_tbl <<- c(1,rep(NA,20))
Factorial_loop(13)
Factorial_reduce(13)
Factorial_func(13)
Factorial_mem(13)

fac_tbl <<- c(1,rep(NA,20))
library(microbenchmark)
microbenchmark(loop <- Factorial_loop(20), 
               reduce <- Factorial_reduce(20),
               func <- Factorial_func(20),
               memo <- Factorial_mem(20))