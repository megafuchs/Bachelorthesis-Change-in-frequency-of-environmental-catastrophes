# Load necessary libraries
# These packages are used for data manipulation, time series analysis, and Bayesian modeling
library(tidyverse)
library(zoo)
library(rethinking)

# Read and prepare the data
# Load the data from a CSV file and clean/filter it for further analysis
data <- read.csv2("data.csv")
d <- data

# Data transformation: focusing on environmental disasters from 1950 onward
# Grouping the data by 5-year intervals to capture long-term trends in disasters
disaster <- c("Climatological", "Hydrological", "Meteorological")
dat <- d %>%
  filter(Year >= 1950) %>%
  mutate(bin = cut_width(Year, 5, boundary = 1945, closed = "left")) %>%
  filter(Continent == "Americas") %>%
  filter(Disaster.Subgroup %in% c(disaster)) %>%
  group_by(bin, Continent, Disaster.Subgroup) %>%
  summarise(count = n(), .groups = "drop") %>%
  complete(bin, Continent, Disaster.Subgroup) %>%
  arrange(Continent, Disaster.Subgroup, bin)

# Assign numerical codes to disaster types and clean up missing data
dat$disaster <- as.numeric(as.factor(dat$Disaster.Subgroup))
dat$interval <- as.numeric(as.factor(dat$bin))
dat$count[is.na(dat$count)] <- 1  # Replace NA values with a small placeholder

# Prepare data for Bayesian analysis
# This list structure will be fed into the Bayesian model
dat5 <- list(
  total = as.integer(dat$count),
  interval = as.integer(dat$interval),
  disaster = as.integer(dat$disaster)
)

# Bayesian Model Setup
# We use a Poisson model with a log-link function to model the number of disasters over time
# The disaster types are treated as categorical variables with random effects (alpha, beta)
m19 <- ulam(
  alist(
    total ~ dpois(lambda),  # Likelihood: disaster counts follow a Poisson distribution
    log(lambda) <- alpha[disaster] + beta[disaster] * interval,  # Linear model on log scale
    vector[3]:alpha ~ multi_normal(0, Rho_interval, sigma_interval),  # Prior for alpha
    vector[3]:beta ~ multi_normal(0, Rho_interval_b, sigma_interval_b),  # Prior for beta
    Rho_interval ~ dlkjcorr(1),  # LKJ prior for correlation matrix
    sigma_interval ~ dexp(1),  # Exponential priors for variance
    Rho_interval_b ~ dlkjcorr(1),
    sigma_interval_b ~ dexp(1)
  ), data = dat5, chains = 4, cores = 4, iter = 10000, control = list(adapt_delta = 0.99)
)

# The model uses a Bayesian approach to estimate the parameters (alpha, beta) for different disaster types
# This captures how the frequency of disasters changes over time for each disaster type
# The log-link ensures that the relationship between disaster count and time interval is multiplicative, suitable for count data

# Interpretation:
# alpha[disaster]: Baseline disaster frequency for each type
# beta[disaster]: The rate of change in disaster frequency over time
# Bayesian hierarchical structure allows the model to share information across disaster types, increasing the robustness of estimates
