"Purpose of script:
query spotify api for album artwork.
list of albums in data folder.
"
# load packages -----------------------------------------------------------
library(spotifyr)
library(magick)
library(readxl)
library(rlist)
library(patchwork)
library(configr)
library(ggplot2)
library(extrafont)
library(dplyr)
library(ggalt)
library(stringr)


# source creds & all funcs ------------------------------------------------
funcs <- list.files("R/", full.names = TRUE)
sapply(funcs, source)

# configure access token --------------------------------------------------
config_secrets("credentials/credentials.toml")
# pull from system variables configured above
access_token <- get_spotify_access_token()

# read data ---------------------------------------------------------------
# detect the tsv in the data folder
datafile <- list.files("data", pattern = "*.tsv")
# read the file in
album_tracker <- read.delim(paste("data", datafile, sep = "/"))
# query api ---------------------------------------------------------------
album_metadata <- get_album_deets(album_tracker$spotify_IDs)

# extract urls ------------------------------------------------------------
album_tracker$img_url <- unlist(lapply(album_metadata, collect_img_urls,
                                       img_size = 2))

# save a patchwork album art ----------------------------------------------
patch_artwork(album_urls = album_tracker$img_url, colnum = 12,
              opt_title = "Album Club 2020/21",
              opt_subtitle = "The Year of the Plague",
              use_font = "Gotham Medium")
# save artwork ------------------------------------------------------------
ggsave(filename = "plots/newplot.png")

# release dates -----------------------------------------------------------

album_tracker$release_year <- unlist(
  lapply(album_metadata, collect_release_years)
  )



