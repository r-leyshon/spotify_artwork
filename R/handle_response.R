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


# collect_release_years ---------------------------------------------------

collect_release_years <- function(album_list = NULL){
  # vector to collect extracted release dates / years
  all_dates <- c()
  # if not character, treat as api response
  if(!is.character(album_list)){
    # get the release dates, some are year some are day granularity
    # cleanse to year only
    date <- as.integer(
      str_sub(album_list[["release_date"]], start = 1, end = 4)
      )

    # if not response, populate with NULL for handling downstream
  } else {
    date <- NA
  }
  # collect the url for this iteration
  append(all_dates, date)
}


