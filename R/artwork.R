
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
patch_artwork <- function(album_list = NULL, image_size = 2, save_path = NULL){
  # return the urls of the specified image size
  img_url <- unlist(list.select(album_list, images$url[image_size]))
  # read the artworks from urls
  all_artworks <- lapply(img_url, read_artworks)
  # patchwork combine
  combined_artworks <- wrap_plots(all_artworks)
  combined_artworks
  # save patchwork output
  ggsave(filename = save_path)
  
}

