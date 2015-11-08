# Linear Regression in R

ggplot(cars, aes(x = speed, y = dist)) + 
  geom_point(shape=1) +
  geom_smooth(method=lm, colour = "#0BB5FF") + 
  ylab("Stopping Distance") + 
  xlab("Initial Speed") + 
  ggtitle("Linear Regression")



lr <- lm(dist ~ speed, data = cars)
lr                # or 'lr$coefficients'. This will return the weights (theta).


lr$residuals      # will return the residuals
plot(lr)          # 4 important plots to evaluate the appropriateness of a linear model

