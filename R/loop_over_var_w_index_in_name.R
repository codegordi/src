# loop_over_var_w_index_var_in_name.R
# > from polys.R (RE: satellite retail density estimation project)
# > adapted from: http://r.789695.n4.nabble.com/R-for-loop-question-td793834.html
#
# INPUT PARMS:
# > n:         number of rows in input matrix
# > vec_orig:  original vector
# > var_str.0: variable name string
#
# c.gutierrez

loop_over_var_index_in_name <- function(n, vec_orig, var_str.0) {
  var0 <- mat.or.vec(n, 2) # create base matrix for coords
  k <- 1
  for ( k in 1:n ) {		# number of possible vertices
    eval(parse(text=sprintf("var%d <- var0", k)))  # create placeholder matrix of same size as original
    for ( i in 1:n ) {	
      vec.nx2 <- vec_orig[var_str.0]
      var_str <- eval(parse(text=sprintf("'var_str.%d'", k)))
      vec.nx2 <- eval(parse(text=sprintf("vec_orig[var_str]")))
      col.k.i <- eval(parse(text=paste("vec.nx2$", var_str, "[i]", sep="")))
      tmp <- rapply(strsplit(col.k.i, split=','), as.numeric)
      eval(parse(text=sprintf("var%d[i,] <- c(tmp[1],tmp[2])", k)))
      rm(tmp, col.k.i); gc()
    }
    rm(var_str, vec.nx2)
  }
}
