Factorial_mem = function(n){
    if (!exists("fac_tbl")) {
        fac_tbl <<- c(1,rep(NA,20))
    }
    
    if(!is.na(fac_tbl[n])){
        fac_tbl[n]
    } else {
        fac_tbl[n] <<- Factorial_mem(n-1)*n
        fac_tbl[n]
    }
}