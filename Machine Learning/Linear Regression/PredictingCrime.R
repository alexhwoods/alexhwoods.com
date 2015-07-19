# crime
library(ggplot2)

crime <- read.csv('crime.csv', header = T)

a <- ggplot(crime, aes(x = policeFunding, y = reportedCrime)) + 
        geom_point(shape=1) +
        geom_smooth(method=lm, colour = "#0BB5FF") + 
        ylab("Crime") + 
        xlab("Police Funding") + 
        ggtitle("Predicting Crime Rate")


lr <- lm(reportedCrime ~ policeFunding, data = crime)
lr                # or 'lr$coefficients'. This will return the weights (theta).


lr$residuals      # will return the residuals
plot(lr)          # 4 important plots to evaluate the appropriateness of a linear model
anova(lr)         # Analysis of Variance Table

# We have a great opportunity for multiple regression here.
# Obviously we can't visualize it in for more than 2 input variables. Here is a graph for that.








lr2 <- lm(reportedCrime ~ graduatedHS25 + teensHS + inCollege + graduatedCollege25 + policeFunding, 
          data = crime)

a <- ggplot(crime, aes(x = policeFunding, y = teenHS, z = reportedCrime)) + 
  geom_point(shape=1) +
  geom_smooth(method=(lm(reportedCrime ~ policeFunding + teenHS)), colour = "#0BB5FF") + 
  ylab("Teens in High School") + 
  xlab("Police Funding") + 
  zlab("Crime") +
  ggtitle("Predicting Crime Rate")



# making the 3d scatterplot!
s <- scatterplot3d(policeFunding, teensHS, reportedCrime, pch = 20, main="Predicting Crime", 
                   color = 'black', angle = 35)

# adding a regression plane
lr3 <- lm(reportedCrime ~ policeFunding + teensHS, data = crime)
s$plane3d(lr3, lty = 'dotted')

# making it a residual plot for 3d
orig <- s$xyz.convert(policeFunding, teensHS, reportedCrime)
plane <- s3d$xyz.convert(policeFunding, teensHS,  fitted(lr3))
negpos <- 1 + (resid(lr3) > 0)
segments(orig$x, orig$y, plane$x, plane$y,
                  col = c("blue", "red")[negpos], lty = (2:1)[negpos])



