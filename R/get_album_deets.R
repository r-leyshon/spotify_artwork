# get_album_deets ---------------------------------------------------------

get_album_deets <- function(album_IDs = NULL){
  # Find strings that are too short or are not urls
  problems <- album_IDs[!grepl("^.{22,}$|^https?:////$", album_IDs)]
  # if problems are found, message and stop
  if(length(problems) > 0) {
    message(paste("Problem found with following IDs / urls:",
                  paste(problems, collapse = ", ")))
    stop("Problems in album_IDs found.")
  } else {
    # use spotifyr client to get album details
    albums <- lapply(album_IDs, function(album_IDs){
    if(!grepl("http", album_IDs)){
      # if the link is not a url, then query spotify api
      message("spotify ID found.")
      get_album(album_IDs)
      
    } else {
      # else this iteration must be a url, simply return it
      message("url found.")
      return(album_IDs)
      }})
    return(albums)
    } 
  }


