
# memory_saver.R

## checking required RAM to load in files
## see also : http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html
## cgutierrez

## function to set classes in advance to reduce memory needed for file load
## ; infile : input (flat) file
## ; my.classes [optional]: column classes vector, if you already know your column classes
## ; n.rows0 : initializing rows to determined field datatypes
## ; n.rows  : [optional] total number of rows in the file (use e.g. CLI wc -l)
## ; set choose.rows = TRUE + max.rows if want to read in lines beyond first n.rows
## ; head : explicitly sets header option
## ; sep : explicitly sets sep (column separator) option; comma-delimited - default
## ; str.as.fact explicitly sets stringsAsFactors option

memsave_loader <- function(infile, my.classes=NULL, n.rows0 = 100, n.rows, choose.rows = FALSE, max.rows, head = TRUE, sep = ",", str.as.fact = FALSE) {
  # turn off comment parsing
  comment.char <- ""
  # set nrows to save memory
  if ( choose.rows == FALSE ) {
    initial <- read.table(infile, nrows = n.rows0, sep = sep, stringsAsFactors = str.as.fact)  # input limited amount of data
    print("First read-through. Initialized.")
  }
  else {
    initial <- read.table(infile, nrows = n.rows, skip = max.rows - 100, sep = sep, stringsAsFactors = str.as.fact)
  } 
  # determine classes
  if ( is.null(my.classes) | length(my.classes) < ncol(initial) ) {
    if ( length(my.classes) < ncol(initial) ) print("You input too few column classes >>> Using classes from initialization.")
    classes <- sapply(initial, class) 
    print(paste0("Identified classes : ", unlist(classes)))
  } else {
    classes <- my.classes
  }
  # load file
  if ( !is.null(n.rows) ) {
    tab.all <- read.table(infile, nrows = n.rows, colClasses = classes, header = head, sep = sep)
  } else {
    tab.all <- read.table(infile, colClasses = classes, header = head, sep = sep)
  }
  print("Done loading. (Whew ....)")
  return(tab.all)
}
