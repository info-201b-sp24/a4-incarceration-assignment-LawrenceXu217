library(ggplot2)
library(dplyr)
library(maps)

prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

prison_data <- prison_data %>%
  group_by(state) %>%
  summarise(
    black_prison_pop = sum(black_prison_pop, na.rm = TRUE),
    total_prison_pop = sum(total_prison_pop, na.rm = TRUE),
    perc_black_prisoners = (black_prison_pop / total_prison_pop) * 100
  ) %>%
  ungroup()

#abb to full names
state_names <- c("AL" = "alabama", "AK" = "alaska", "AZ" = "arizona", "AR" = "arkansas", 
                 "CA" = "california", "CO" = "colorado", "CT" = "connecticut", "DE" = "delaware",
                 "DC" = "district of columbia", "FL" = "florida", "GA" = "georgia", "HI" = "hawaii",
                 "ID" = "idaho", "IL" = "illinois", "IN" = "indiana", "IA" = "iowa", 
                 "KS" = "kansas", "KY" = "kentucky", "LA" = "louisiana", "ME" = "maine", 
                 "MD" = "maryland", "MA" = "massachusetts", "MI" = "michigan", "MN" = "minnesota", 
                 "MS" = "mississippi", "MO" = "missouri", "MT" = "montana", "NE" = "nebraska", 
                 "NV" = "nevada", "NH" = "new hampshire", "NJ" = "new jersey", "NM" = "new mexico", 
                 "NY" = "new york", "NC" = "north carolina", "ND" = "north dakota", "OH" = "ohio", 
                 "OK" = "oklahoma", "OR" = "oregon", "PA" = "pennsylvania", "RI" = "rhode island", 
                 "SC" = "south carolina", "SD" = "south dakota", "TN" = "tennessee", "TX" = "texas", 
                 "UT" = "utah", "VT" = "vermont", "VA" = "virginia", "WA" = "washington", 
                 "WV" = "west virginia", "WI" = "wisconsin", "WY" = "wyoming")

prison_data$state <- state_names[prison_data$state]

# Load U.S. state map data
us_states_map <- map_data("state")

map_data <- merge(us_states_map, prison_data, by.x = "region", by.y = "state", all.x = TRUE)

ggplot(data = map_data, aes(x = long, y = lat, group = group, fill = perc_black_prisoners)) +
  geom_polygon(color = "white") +
  scale_fill_viridis_c(
    name = "Percentage of Black Prisoners",
    na.value = "lightgrey",  # NA Value
    labels = scales::percent_format(accuracy = 1)
  ) +
  coord_fixed(1.3) +
  labs(
    title = "Geographic Distribution of Black Prisoner Percentage by State",
    subtitle = "Measured as a percentage of the total prison population per state"
  ) +
  theme_minimal() +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))




