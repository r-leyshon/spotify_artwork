# get_album_deets ---------------------------------------------------------

get_album_deets <- function(album_IDs = NULL){
  # use spotifyr client to get album details
  albums <- lapply(album_IDs, function(album_IDs){
    # if the link is not a url, then query spotify api
    if(!grepl("http", album_IDs)){
      message("this is a spotify ID")
      get_album(album_IDs)
      # else this iteration must be a url, simply return it
    } else {
      message("this is a url")
      return(album_IDs)}
    })
  
  return(albums)
}
