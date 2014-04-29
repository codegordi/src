
#####################################################
#
# split_df.R
#   split dataframe into train + test sets for
#   modeling
#   - adapted from Stephen Turner's 2/24/11 blog post
#
# cgutierrez@
#####################################################

split_df <- function(dataframe, train.fraction = 0.7, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  train.index <- sample(index, trunc(length(index)*train.fraction))
  train.set <- dataframe[train.index, ]
  test.set <- dataframe[-train.index, ]
  list(train.set = train.set,test.set = test.set)
}