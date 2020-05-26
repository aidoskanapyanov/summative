Factorial_loop = function(n){
    answer = 1
    for (i in seq(n)) {
        answer = answer*i
    }
    return(answer)
}