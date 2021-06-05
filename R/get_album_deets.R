# get_album_deets ---------------------------------------------------------

get_album_deets <- function(album_IDs = NULL){
  # use spotifyr client to get album details
  albums <- lapply(album_IDs, get_album)
  return(albums)
}
