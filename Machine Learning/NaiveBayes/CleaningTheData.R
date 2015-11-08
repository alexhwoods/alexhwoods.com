data <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
head(data)

# First we have to split the data. 
one <- subset(data, data$admit == 1)
zero <- subset(data, data$admit == 0)


oneTrain <- one[sample(1:nrow(one), round(nrow(one)*.75), replace = F), ]

# all the indeces for the test data
index <- row.names(one) %in% setdiff(row.names(one), row.names(oneTrain))

# now we just take the rows with the proper indeces!
oneTest <- one[index, ]


# now let's do the same thing for those with admit == 0
zeroTrain <- zero[sample(1:nrow(zero), round(nrow(zero)*.75), replace = F), ]
indexZ <- row.names(zero) %in% setdiff(row.names(zero), row.names(zeroTrain))
zeroTest <- zero[indexZ, ]


# that what much quicker since we did it once before, but we should just by making 
# sure the number of rows add up!
nrow(zeroTrain) + nrow(zeroTest) == nrow(zero)       # and it does :)


# one last data cleaning thing to do. We have to combine the corresponding data frames to 
# create the training data, and combine the other corresponding ones to create the 
# test data. This is done using the rbind function.
train <- rbind(oneTrain, zeroTrain)
test <- rbind(oneTest, zeroTest)


# now we have 75% of the data (split properly wieghted by admit value) in the training 
# data, and 25% in the test data. Let's clean up our work environment now.
rm(one, oneTest, oneTrain, zero, zeroTest, zeroTrain, index, indexZ)

# I'll export some csv's so people who are trying to do this one their own don't have
# to split the data if they don't want to, but it's great practice in R. 
write.csv(train, file = "train.csv")
write.csv(test, file = "test.csv")