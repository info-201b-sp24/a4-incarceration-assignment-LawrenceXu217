library(ggplot2)
library(dplyr)

# Load the data
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

# Calculate prison population density per 100,000 people
prison_data <- prison_data %>%
  mutate(
    prison_density_per_100k = (total_prison_pop / total_pop) * 100000,  # Ensure total_pop is the correct column name for total population
    perc_black_prisoners = (black_prison_pop / total_prison_pop) * 100  # Calculate percentage of Black prisoners
  )

# Plotting the relationship between prison population density and percentage of Black prisoners
ggplot(data = prison_data, aes(x = prison_density_per_100k, y = perc_black_prisoners)) +
  geom_point(alpha = 0.6) +  # Add points with some transparency
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add a linear regression line
  labs(
    title = "Relationship Between Prison Population Density and Percentage of Black Prisoners",
    x = "Prison Population Density per 100,000",
    y = "Percentage of Black Prisoners"
  ) +
  theme_minimal()  # Use a minimal theme for a cleaner look


