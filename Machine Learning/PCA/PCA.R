# PCA in R

# The numbers give the percent proportion of favourable responses to seven questions in each department.
# note - the 'priveleges' feature is to what extent the dept DOES NOT allow special priveleges.

# *********************************************************

# Step 1 - Normalize the data. (Subtract by the mean and divide by the standard deviation, for each feature)
names(attitude)
attach(attitude)         # to save me having to type 'attitude' 20 times
attitude$rating <- (rating - mean(rating)) / sd(rating)
attitude$complaints <- (complaints - mean(complaints)) / sd(complaints)
attitude$privileges <- (privileges - mean(privileges)) / sd(privileges)
attitude$learning <- (learning - mean(learning)) / sd(learning)
attitude$raises <- (raises - mean(raises)) / sd(raises)
attitude$critical <- (critical - mean(critical)) / sd(critical)
attitude$advance <- (advance - mean(advance)) / sd(advance)

# re-attach so it calls the updated feature
attach(attitude)

summary(attitude)      # means are all 0
sd(privileges)         # and sd's are all 1 (you can check them all if you like)


# *********************************************************

# Step 2 - The Covariance Matrix
# this is actually super freaking simple..thanks R :)
cov(attitude)

# Quiz question - Why is the diagonal all 1's?                                                      Because we normalized the data to have an sd and variance of 1!



# *********************************************************

# Step 3 - Getting the Principal Components
x <- eigen(cov(attitude))
x$vectors

# just out of curiosity, I'm going to check this (%*% is matrix multiplication in R)
cov(attitude) %*% x$vectors[, 1]   # gives the same values as...
x$values[1] * x$vectors[, 1]


# we now need to form a feature vector containing the number of eigenvectors you want



# *********************************************************

# Step 4 - Arriving at a new dataset
# This is the easiest step!
A <- x$vectors[, 1:3]
B <- data.matrix(attitude)          # because we can't do matrix multiplication with data frames!

# now we arrive at the new data by the above formula!
newData <- t(A) %*% t(B)


# note - in the newData matrix, each row is a feature, and each column is a data point. Let's change that
newData <- t(newData)
newData <- data.frame(newData)
names(newData) <- c("feat1", "feat2", "feat3")
# If we only use two features, we are still seeing 70% of the variance, 3 features, 81%


ggplot(dat, aes(x=xvar, y=yvar)) +
  geom_point(shape=1)      # Use hollow circles

c <- ggplot(newData, aes(x = feat1, y = feat2)) + 
      geom_point(shape = 1) + ggtitle("Data After PCA") + 
      xlab("Feature 1") + ylab("Feature 2")


# Talk about the existence of only a mathmatical significance to the features
# and how from here you can go on to do clustering or other ML algorithms





# *********************************************************

# One more question. How many principle components should we take? Graph it!
# Plot the proportion of the eigenvalue sum that each eigenvector contains.
x$values
eigensum <- sum(x$values)
props <- x$values / eigensum

library(ggplot2)

props <- data.frame(props)
props$eigenvalue <- seq(1:7)

a <- ggplot(props, aes(x = eigenvalue, y = props)) + geom_bar(stat = "identity", fill = "#3299CC", colour = "black") +
      ggtitle("Proportion of Variance Captured By Component") + ylab("Proportion of Variance") +
      xlab("Component Number")




# **********************************************************

# Extra Step - How To Do PCA Automatically in R (prcomp)

# Don't forget to scale the data, or set scale = True
prcomp(attitude)

# does it look like the eigenvectors from before? It should! Note - if some vector v is an eigenvector,
# then c*v is an eigenvector, for any scalar c. (My point is, it's cool if the signs are switched).

plot(prcomp(attitude))      # similar to my plot above with the blue bars
summary(prcomp(attitude))
biplot(prcomp(attitude))    # This one is pretty cool...

# At the very least, this affirms that what we did above is right! 

