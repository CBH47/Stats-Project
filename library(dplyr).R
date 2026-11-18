# install.packages("dplyr")   # run once if you don't have it
library(dplyr)

df <- read.csv("spotify_songs.csv")

d <- df |> distinct(track_id, .keep_all = TRUE)

# Strict filter: high valence, low danceability
d |>
  filter(valence > 0.85, danceability < 0.6) |>
  arrange(danceability) |>
  select(track_name, track_artist, playlist_genre, danceability, valence, tempo)

# Or rank by the gap, with no thresholds to tune
d |>
  mutate(gap = valence - danceability) |>
  arrange(desc(gap)) |>
  select(track_name, track_artist, playlist_genre, danceability, valence, tempo) |>
  head(10)
