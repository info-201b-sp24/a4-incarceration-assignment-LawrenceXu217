library(ggplot2)
library(dplyr)

# Load the data
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

# Convert 'year' to a factor and calculate the percentage of black prisoners
prison_data$year <- as.factor(prison_data$year)
prison_data$perc_black_prisoners <- (prison_data$black_prison_pop / prison_data$total_prison_pop) * 100

# Filter data to include only every tenth year
# Assuming dataset starts at a year that is a multiple of 10
# Adjust the modulo condition or subset directly by specific years as needed
prison_data_filtered <- prison_data %>%
  filter(as.integer(year) %% 5 == 0)  # Change to match the specific years or intervals you need

# Plot the filtered data
ggplot(data = prison_data_filtered, aes(x = year, y = perc_black_prisoners, group = 1, color = year)) +
  geom_line() +  # Line plot to show trends over time
  geom_point() +  # Add points to emphasize data points per year
  labs(
    title = "Trend of Percentage of Black Prisoners Over Time",
    x = "Year",
    y = "Percentage of Black Prisoners",
    color = "Year"  # Legend title if using color to distinguish years
  ) +
  theme_minimal()  # Apply a clean minimal theme



