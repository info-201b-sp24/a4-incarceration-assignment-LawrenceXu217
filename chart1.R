library(ggplot2)

prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

prison_data$year <- as.factor(prison_data$year)
prison_data$perc_black_prisoners <- (prison_data$black_prison_pop / prison_data$total_prison_pop) * 100

# Modified code to show trends over time
ggplot(data = prison_data, aes(x = year, y = perc_black_prisoners, group = 1, color = year)) +
  geom_line() +  # Change to line plot to show trends over time
  geom_point() +  # Optional: add points to emphasize data points per year
  labs(
    title = "Trend of Percentage of Black Prisoners Over Time",
    x = "Year",
    y = "Percentage of Black Prisoners",
    color = "Year"  # Legend title if using color to distinguish years
  ) +
  theme_minimal()  # Clean minimal theme


