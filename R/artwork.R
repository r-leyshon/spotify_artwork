# read artwork images -----------------------------------------------------
read_artworks <- function(urls = NULL){
  print(urls)
  # read in the image
  img <- image_read(urls)
  # convert to ggplot for easy patchwork
  plt <- image_ggplot(img, interpolate = FALSE)
  return(plt)
}

# collect_urls ------------------------------------------------------------
collect_urls <- function(album_list){
  # vector to collect extracted urls
  url_list <- c()
  # if not character, treat as api response
  if(!is.character(album_list)){
    url <- album_list[["images"]][["url"]][[image_size]]
    # otherwise, treat as character
  } else {
    url <- album_list[1]
    }
  # collect the url for this iteration
  append(url_list, url)
}


# patch_artwork -----------------------------------------------------------
patch_artwork <- function(album_list = NULL, image_size = 2, colnum = NULL,
                          rownum = NULL, opt_title = NULL, opt_subtitle = NULL,
                          use_font = NULL, font_col = "#1DB954",
                          panel_col = "#000000"){
  # retrieve all the required urls
  img_url <- unlist(lapply(album_list, collect_urls))  
  # read the artworks from urls
  all_artworks <- lapply(img_url, read_artworks)
  # patchwork combine
  combined_artworks <- wrap_plots(all_artworks, ncol = colnum, nrow = rownum)
  # Add specified title
  combined_artworks + plot_annotation(title = opt_title,
                                      subtitle = opt_subtitle) &
    theme(text = element_text(family = use_font, colour = font_col),
          plot.background = element_rect(fill = panel_col)
          )
  
}

