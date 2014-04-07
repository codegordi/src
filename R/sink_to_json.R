#####################################
#
# sink_to_json.R
#
# one-stop function to output JSON-
#   formatted R object
#
# cgutierrez@
#####################################
require(rjson)
require(testthat)

sink_to_json = function(obj, sink_name=paste0(obj,".json"), verbose=FALSE)  {
  
  assert_that(class(obj)=="character")
  
  sink(sink_name)
  cat(obj)
  file.show(sink_name)
  
}