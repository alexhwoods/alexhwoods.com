# Suppose a car rental agency has three locations in Ottawa: Downtown location (labeled A), East end location (labeled B) and a West end location (labeled C). The agency has a group of delivery drivers to serve all three locations. The agency's statistician has determined the following:
# 
# 1.      Of the calls to the Downtown location, 30% are delivered in Downtown area, 30% are delivered in the East end, and 40% are delivered in the West end
# 
# 2.      Of the calls to the East end location, 40% are delivered in Downtown area, 40% are delivered in the East end, and 20% are delivered in the West end
# 
# 3.      Of the calls to the West end location, 50% are delivered in Downtown area, 30% are delivered in the East end, and 20% are delivered in the West end.
# 
# After making a delivery, a driver goes to the nearest location to make the next delivery. This way, the location of a specific driver is determined only by his or her previous location.
# 
# We model this problem with the following matrix:

library(markovchain)

rentalStates <- c("Downtown", "East", "West")
rentalTransition <- matrix(c(0.3, 0.3, 0.4, 
                      0.4, 0.4, 0.2, 
                      0.5, 0.3, 0.2),
                      byrow = T, nrow = 3, dimnames = list(rentalStates, rentalStates))

mcRental <- new("markovchain", states = rentalStates, byrow = T, 
                transitionMatrix = rentalTransition, name = "Rental Cars")



# We can access the transition matrix just by calling the mc object
mcRental[1]  # the probabilities that we go Downtown, East, and West, given that we are currently Downtown

plot(mcRental)  # we can plot it

transitionProbability(mcRental, "Downtown", "West")   # the prob that a driver will go from downtown to West

# Here is a question to set up some of the functions 
# Given we are downtown, what is the probability we will be downtown in two trips?
# We can go Downtown -> Downtown, 
a <- 0.3 * 0.3

# East -> Downtown (note that to we have to get the probability of going Downtown from the East location),
b <- 0.3 * 0.4

# West -> Downtown (same logic here)
c <- 0.4 * 0.5

a + b + c    # The probability that we will be downtown in 2 trips.

# That isn't something you want to be doing, especially if you want the probabilities after 20 trips.
# In turns out though, we can get the same results by squaring the matrix.
mcRental ^ 2

# We can do this for any number of trips, where the number of trips is the exponent.
mcRental ^ 20   # notice how where you are starts to become irrelevant, as the number of trips increases.

# It's also important to note that the transition matrix T ^ n, will converge as n increases, 
# given that there are no 0's or 1's in our initial matrix.


# So if we had 70 drivers, how many drivers would be at the West location after 30 trips?
# This distribution, the converged probabilities of each state, where the location at which you start
# is irrelevant (because n is sufficiently large), is called the stationary distribution.
# We can access it using the steadyStates() method.
mcRental ^ 30
70*steadyStates(mcRental)      



# Now let's look at some of the other methods that the markovchain package has
summary(mcRental)
conditionalDistribution(mcRental, "Downtown")


