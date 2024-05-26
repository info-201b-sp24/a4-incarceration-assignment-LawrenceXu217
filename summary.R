library(dplyr)

# Load the data from the URL
prison_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

# Calculate new variables
prison_data <- prison_data %>%
  mutate(
    prison_rate_per_population = (total_prison_pop / total_pop) * 100,
    perc_black_prisoners = (black_prison_pop / total_prison_pop) * 100,
    perc_white_prisoners = (white_prison_pop / total_prison_pop) * 100,
    youth_incarceration_rate = (total_prison_pop / total_pop_15to64) * 100000,
    gender_disparity_index = (male_prison_pop - female_prison_pop) / total_prison_pop * 100
  )

# Optional: Check the newly created variables
summary(select(prison_data, prison_rate_per_population, perc_black_prisoners, 
               perc_white_prisoners, youth_incarceration_rate, gender_disparity_index))