# read artwork images -----------------------------------------------------
read_artworks <- function(urls = NULL){
  print(urls)
  # read in the image
  img <- image_read(urls)
  # convert to ggplot for easy patchwork
  plt <- image_ggplot(img, interpolate = FALSE)
  return(plt)
}

# patch_artwork -----------------------------------------------------------
patch_artwork <- function(album_list = NULL, image_size = 2, colnum = NULL,
                          rownum = NULL, opt_title = NULL, opt_subtitle = NULL,
                          use_font = NULL, font_col = "#1DB954",
                          panel_col = "#000000"){
  # return the urls of the specified image size
  img_url <- unlist(list.select(album_list, images$url[image_size]))
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

