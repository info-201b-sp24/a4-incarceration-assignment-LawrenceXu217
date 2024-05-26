# Load necessary libraries
library(ggplot2)
library(dplyr)
library(maps)
library(readr)

# Load your data
#prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

# Calculate the percentage of black prisoners by state
prison_data <- prison_data %>%
  group_by(state) %>%
  summarise(
    black_prison_pop = sum(black_prison_pop, na.rm = TRUE),
    total_prison_pop = sum(total_prison_pop, na.rm = TRUE),
    perc_black_prisoners = (black_prison_pop / total_prison_pop) * 100
  ) %>%
  ungroup()

# Make sure state names are lowercase to match the map data
prison_data$state <- tolower(prison_data$state)

# Load U.S. state map data
us_states_map <- map_data("state")

# Merge the geographic data with the prison data
map_data <- merge(us_states_map, prison_data, by.x = "region", by.y = "state", all.x = TRUE)

# Create the map using ggplot2
ggplot(data = map_data, aes(x = long, y = lat, group = group, fill = perc_black_prisoners)) +
  geom_polygon(color = "white") +
  scale_fill_viridis_c(
    name = "Percentage of Black Prisoners",
    na.value = "lightgrey",  # to clearly show states with no data
    labels = scales::percent_format(accuracy = 1)
  ) +
  coord_fixed(1.3) +  # This helps to maintain the aspect ratio of the map
  labs(
    title = "Geographic Distribution of Black Prisoner Percentage by State",
    subtitle = "Measured as a percentage of the total prison population per state"
  ) +
  theme_minimal() +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))




