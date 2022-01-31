"purpose: filter user data to specified string value."


filter_user <- function(
  tsv_loc = NULL,
  user_value = NULL
){
  if(is.null(tsv_loc)){
    stop("'tsv_loc' is null. Please pass the file path to the tsv file.")
    
  } else if(!file.exists(tsv_loc)){
    stop(sprintf("No file found at %s", tsv_loc))
    
  } else if (!grepl(".tsv$", basename(tsv_loc))){
    stop("'tsv_loc' should be a path to a tsv file.")
    
  } else(
    all_albums <- read.delim(tsv_loc, check.names = TRUE)
    
  )
  
  # Now the file is read, filter by specified user_value
  spec_albums <- all_albums[grep(user_value, all_albums$poster, perl = TRUE), ]
  
  if(nrow(spec_albums) == 0){
    stop("No entries for the specified 'user_value were found")
  }
  
  return(spec_albums)

}
