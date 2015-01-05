## wrappers.R

## wrapper function to invoke "helloA" at the shell.

src.dir.c <- '~/src/cpp/'

helloA <- function() {
    system(paste0(src.dir.c, "helloA"))
}

## wrapper function to invoke helloB with a named argument
dyn.load(paste0(src.dir.c, "helloB.so"))
helloB <- function() {
    result <- .C("helloB",
                     greeting="")
      return(result$greeting)
}

## wrapper function to invoke helloC with two arguments
dyn.load(paste0(src.dir.c, "helloC.so"))
helloC <- function(greeting) {
    if ( !is.character(greeting) ) {
      stop("Argument 'greeting' must be of type _character_.")
    }
    result <- .C("helloC",
                 greeting=greeting,
                 count=as.integer(1))
    return(result$count)
}

