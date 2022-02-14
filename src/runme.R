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
config_secrets(".git_ignore/secrets.toml")
# pull from system variables configured above
access_token <- get_spotify_access_token()

# read data ---------------------------------------------------------------
# detect the tsv in the data folder
datafiles <- list.files("data", pattern = "*.tsv", full.names = TRUE)
# read the file(s) in

album_trackers <- lapply(datafiles, read.delim)
album_tracker <- rlist::list.stack(album_trackers, fill = TRUE)
try(album_tracker <- dplyr::select(album_tracker, -Date_tracking))

# filter to specified user ------------------------------------------------
# optional



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

# filter df by poster column values and assign ----------------------------

separate_tables(df = album_tracker, target = "poster")

# list all resulting dfs --------------------------------------------------

poster_dfs <- ls()[grepl("df_", ls())]
listed_dfs <- lapply(poster_dfs, get)

# patch artworks for all dfs ----------------------------------------------

urls_only <- list.select(listed_dfs, img_url)
