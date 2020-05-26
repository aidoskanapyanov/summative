Factorial_reduce = function(n){
    numeric(n)
    require(purrr)
    sequence = seq(n)
    reduce(sequence, function(x,y) as.numeric(x)*as.numeric(y))
}