# A good starting point (before actually coding the algorithm) is always visualizing the 
# data. It helps you see any craziness, or if your underlying assumptions (Normal, etc)
# are reasonable.

# ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1)

library(ggplot2)
ggplot(train, aes(x = gpa, y = gre, color = as.integer(admit))) + 
  geom_point(shape = 1)

# mmm I can't stand when the colors go on a spectrum when it's obviously discrete, 
# so I'm going to fix that.
train$admit2 = F
for (i in 1:nrow(train)) {
  if (train[i,1] == 1) train[i,5] = T
}


# now let's try this again...
ggplot(train, aes(x = gpa, y = gre, color = admit2)) + 
  geom_point(shape = 1) + 
  xlab("GPA") + 
  ylab("GRE") +
  ggtitle("Distribution of Students")


# So just looking at the data shows that there isn't exactly the clearest boundaries.
# Who knows how UCLA makes those decisions...I guess not statistically haha
# but anyway, we continue

# So the way to do this is to split the training data by class, then calculate the all 
# the probabilites for each class. For example, given that a student was admitted, what
# is the probability they had a GPA of 3.4?

one <- subset(train, admit == 1)
zero <- subset(train, admit == 0)

# We calculate the priors based on the distribution of the two classes, admitted or not. 
# So prior probability of being admitted = number of admitted students / number of rejected
# students.

priorAdmitted <- nrow(one) / nrow(train)
priorRejected <- nrow(zero) / nrow(train)


# Now calculating the conditional likelihood for a new given test example, we have to 
# do this using a Gaussian Distribution that supposedly exists within each class.
# So, let's write a function to give this probability

condProb <- function(df, testObj, var) {
  # note - col2 = gre, col3 = gpa, col4 = rank...let's make a dictionary
  dict <- vector(mode = "list", length = 3)
  names(dict) <- c("gre", "gpa", "rank")
  dict[[1]] <- 2; dict[[2]] <- 3; dict[[3]] <- 4
  
  col <- as.integer(dict[var])
  
  val <- testObj[1, col]    # by doing this the "val" can represent gre, gpa, or rank, depending on what i want
  
  mu <- mean(df[, col])
  sigma <- sd(df[, col])
  
  # we have to account for what side of the mean the value is on
  if (val < mu) return(pnorm(val, mean = mu, sd = sigma))
  else return(pnorm(val, mean = mu, sd = sigma, lower.tail = F))
  
}


# I need to test the function I just made. 
meanGPA <- mean(one[, 3])
sdGPA <- sd(one[, 3])
testGPA <- test[1,3]   # the first student in the test data

testProb <- pnorm(testGPA, mean = meanGPA, sd = sdGPA, lower.tail = F)   # = 0.3344

# so, using the above function, for the first student, we should get 0.3344
condProb(one, test[1,], "gpa") == testProb


# and it works :)


# Now we can calculate the probability that test vector x is in each class, admitted or
# rejected. And the max probability of the two will be what our classifier predicts.


# note - condProb(df, testObj, var)
# where df is one or zero, depending on the class we're calculating for
# testObj is a row of test data, for example test[1, ] would be the first row
# var is gpa, gre, or rank, and it just depends on which I'm calculating for. 
# be sure to enter var as a string


# let's create a new column so we have somewhere to put our predictions
test$predict <- 0

# prob(C|x) = p(C) * product(p(xi|Ck))
# and in reality there is some constant, p(x), in the denominator of that formula,
# but since it's a constant it doesn't matter for classifying. The multiplying together
# of the p(xi | Ck)'s requires conditional independence, a naive assumption ;)


for (i in 1:nrow(test)) {
  probAdmit <- priorAdmitted * condProb(one, test[i, ], "gre") * condProb(one, test[i, ], "gpa") * condProb(one, test[i, ], "rank")
  probReject <- priorRejected * condProb(zero, test[i, ], "gre") * condProb(zero, test[i, ], "gpa") * condProb(zero, test[i, ], "rank")
  
  print(i)
  if (probAdmit > probReject) test[i, 5] = 1
  else test[i, 5] = 0
  
}

# now we have the predictions! It's pretty clear that the algorithm predicted rejected
# more than accepted, probably because rejected has a higher prior (a lot more people
# in the training data got rejected than accepted)

# Let's visualize it, and calculate an accuracy measure for the algorithm
test$correct <- F

for (i in 1:nrow(test)) {
  a <- test[i,1]
  b <- test[i,5]
  if (xor(a,b) == F) test[i,6] = T         # programming question for you -  why does xor work here?
  else test[i, 6] = F
}


accuracy <- nrow(subset(test, correct == T)) / nrow(test)   # 0.65. I'll take it, considering how finnicky college admissions seem to be.


# one good habit is to test it against a naive Bayes package in R
install.packages("e1071")
library (e1071)

# note - the variable "admit" is numeric, so we have to make it categorical using
# as.factor. This caused problems for me haha.
model <- naiveBayes(as.factor(admit) ~ gre + gpa + rank, data = train)
model             # we got the same A priori probabilities...that's a good start haha


pred <- predict(model, test)
table(pred, test[,1])


# and if you do the math and get an accuracy rating from that table, you'll find it is 
# 0.63, 0.02 less than our model :)