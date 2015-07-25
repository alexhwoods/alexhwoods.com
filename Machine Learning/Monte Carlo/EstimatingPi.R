# estimating pi using Monte Carlo methods. This code won't run perfectly for you, because I 
# didn't save everything I did, like adding vectors to a dataframe named Pi. 
# Just the important stuff is here. 

center <- c(2.5, 2.5)                      # the center of the circle
radius <- 2.5
distanceFromCenter <- function(a) {
  sqrt(sum((center - a) ^ 2))
}

# let's define a 5 by 5 square matrix
points <- c(0,0, 0,5, 5,5, 5,0)
square <- matrix(points, nrow = 4, ncol = 2, byrow = TRUE)


# now all I need to do is make matrix A a matrix of real simulated points.
n <- 100                         # number of points
A <- matrix(runif(n*2, min=0, max=5), nrow = n, ncol = 2, byrow = T)   # random sampling occurs here!!!

# here's how you'll test if it's in the circle. 
b <- apply(A, 1, distanceFromCenter)           
d <- subset(b, b < radius)                         # if you know a better way to do this part, email me.
num <- length(d) / length(b)

piVec <- c()

for (i in 1:2000) {
  n <- i
  A <- matrix(runif(n*2, min=0, max=5), nrow = n, ncol = 2, byrow = T)
  b <- apply(A, 1, distanceFromCenter)
  d <- subset(b, b < radius)
  num <- length(d) / length(b)
  piVec[i] = num*4
}


##### Graphing the error

# note - if you want this part to work for you, you'll have to create the appropriate data frame from the piVec vector.

ggplot(Pi, aes(x=ind, y = error)) +
  geom_line(colour = '#388E8E') + 
  ggtitle("Error") + 
  xlab("Sample Size") + 
  ylab("Error")










