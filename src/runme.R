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

# manually correct any NAs ------------------------------------------------

# album_tracker$album[81]
# release date for above entry is 1991
album_tracker$release_year[81] <- 1991


# visualise the distribution ----------------------------------------------
# for this bit a poster dimension is required

album_tracker %>% 
  group_by(poster) %>% 
  mutate(
    max = max(release_year),
    min = min(release_year),
    yr_range = max - min,
    yr_median = median(release_year)) %>%
  ggplot(aes(x = min, xend = max, y = reorder(poster, -yr_range))) +
  geom_dumbbell(colour = "#1DB954", colour_x = "#1DB954", colour_xend = "#1DB954",
                size_x = 2, size_xend = 2) +
  geom_point(aes(x = release_year, y = poster), alpha = 0.3, colour = "white") +
  geom_point(aes(x = yr_median, y = poster), shape = "cross", colour = "#1DB954", size = 2) +
  labs(
    y = "",
    x = "Release Year",
    title = "Album Club 2020/21",
    subtitle = "Albums by Year of Release"
  ) +
  theme(text = element_text(family = "Gotham Medium", colour = "#1DB954"),
        plot.background = element_rect(fill = "#191414"),
        axis.text.x = element_text(colour = "white"),
        axis.text.y = element_text(colour = "white"),
        panel.grid = element_blank(),
        panel.background = element_rect("#191414"),
        plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)
  ) +
  scale_y_discrete(position = "right")
  

