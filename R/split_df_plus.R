
#####################################################
#
# split_df_plus.R
#   split dataframe into multiple sets for
#   chunking
#
# cgutierrez@
#####################################################

split_df_plus <- function(dataframe, split.fraction = NULL, split.n = 5000, seed = NULL) {
  
  if (!is.null(seed)) set.seed(seed)

  index <- 1:nrow(dataframe)
  
  if (!is.null(split.fraction)) {
    print("Not implemented yet.")  # TODO
  } 
  
  if (!is.null(split.n)) {
    
    splits <- (trunc(nrow(dataframe)/split.n)+1)
    for ( ii in 1:splits ) {
      print(ii)
      if ( ii < splits ) {
        index.ii <- sample(index, trunc(split.n))
      } else {
        index.ii <- sample(index, length(index)-trunc(split.n)*(splits-1))
      }
      if ( ii==1 ) { 
        index.rest <- setdiff(index.ii, as.integer(rownames(dataframe))) 
      } else {
        index.rest <- setdiff(index.ii, index.rest)
      }
      eval(parse(text=sprintf("set.%d <- dataframe[index.ii, ]", ii)))
      eval(parse(text=sprintf("set.%d$orig.rownames <- rownames(set.%d)", ii, ii)))
      
    }
    return(sapply(1:splits, function(ii) eval(parse(text=sprintf("list(set.%d = set.%d)", ii, ii)))))
    
  } else { print("Input either a split fraction or chunk size (n).") }

}
