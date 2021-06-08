# read artwork images -----------------------------------------------------
read_artworks <- function(urls = NULL){
  # find any url that doesn't contain http(s)://
  problems <- urls[!grep("^https?:////$", urls)]
  # if found, stop with a message
  if(length(problems) > 1){
    message(paste("Problem found with following IDs urls:",
                  paste(problems, collapse = ", ")))
    stop("Problems in urls found.")
  } else {
    # read in the image
    img <- image_read(urls)
    # convert to ggplot for easy patchwork
    plt <- image_ggplot(img, interpolate = FALSE)
    return(plt)
  }
}

# patch_artwork -----------------------------------------------------------
patch_artwork <- function(album_urls = NULL, colnum = NULL,
                          rownum = NULL, opt_title = NULL, opt_subtitle = NULL,
                          use_font = NULL, font_col = "#1DB954",
                          panel_col = "#000000"){
  # read the artworks from urls, if read_artworks errors, propagate error
  tryCatch({all_artworks <- lapply(album_urls, read_artworks)}) 
  # patchwork combine
  combined_artworks <- wrap_plots(all_artworks, ncol = colnum, nrow = rownum)
  # Add specified title
  combined_artworks + plot_annotation(title = opt_title,
                                      subtitle = opt_subtitle) &
    theme(text = element_text(family = use_font, colour = font_col),
          plot.background = element_rect(fill = panel_col)
          )
  
}

