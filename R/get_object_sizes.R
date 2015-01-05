## get_object_sizes.R
##
## wrapper for object.size() to list all objects in current session

sapply(ls(), function(x) object.size(get(x)))