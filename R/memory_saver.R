
# memory_saver.R

## checking required RAM to load in files

## function to set classes in advance to reduce memory needed for file load
## ; set choose.rows = TRUE + max.rows if want to read in lines beyond first n.rows
check_RAM <- function(infile, n.rows = 100, choose.rows = FALSE, max.rows) {
  # turn off comment parsing
  comment.char <- ""
  # set nrows to save memory
  if ( choose.rows == FALSE ) {
    initial <- read.table(infile, nrows = n.rows)  # input limited amount of data
  }
  else {
    initial <- read.table(infile, nrows = n.rows, skip = max.rows - 100)
  } 
  classes <- sapply(initial, class)  # determine classes
  tab.all <- read.table(infile, colClasses = classes)
}
