Factorial_reduce = function(n){
    require(purrr)
    sequence = seq(n)
    reduce(sequence, function(x,y) x*y)
}