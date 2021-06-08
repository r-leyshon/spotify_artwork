# collect_img_urls --------------------------------------------------------
collect_img_urls <- function(album_list = NULL, img_size = 2){
  # vector to collect extracted urls
  url_list <- c()
  # if not character, treat as api response
  if(!is.character(album_list)){
    url <- album_list[["images"]][["url"]][[img_size]]
    # otherwise, treat as character
  } else {
    url <- album_list[1]
  }
  # collect the url for this iteration
  append(url_list, url)
}

# collect_release_date ----------------------------------------------------


