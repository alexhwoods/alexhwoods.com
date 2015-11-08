install.packages("markovchain")
library(markovchain)

weatherStates <- c("sunny", "cloudy", "rain")
weatherMatrix <- matrix(data = c(0.70, 0.2, 0.1,
                                 0.3, 0.4, 0.3,
                                 0.2, 0.45, 0.35), 
                        byrow = TRUE, nrow = 3, dimnames = list(weatherStates, weatherStates))
                                  
mcWeather <- new("markovchain", states = weatherStates, byrow = T, 
                 transitionMatrix = weatherMatrix, name = "Weather")



r <- function(t) {
  x <- sqrt(80000 / pi)
  return ((x/80)*t)
}

r(80)^2 * pi
