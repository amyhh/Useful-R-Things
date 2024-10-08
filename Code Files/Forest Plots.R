#primary intention to treat analysis 
#rt-pcr confirmed covid-19

#Hazard ratios 

country.name <- c("Canada", "Israel", "Pakistan", "Egypt", "All sites")
HR <- c(2.83, 1.54, 1.50, 0.95, 1.14)
lower.CI <- c(0.75, 0.43, 0.25, 0.60, 0.77)
upper.CI <- c(10.72, 5.49, 8.98, 1.50, 1.69)
data <- data.frame(country.name, HR, lower.CI, upper.CI)
print(data)


#with forestplot package - have questions about why the black bars are so big
install.packages("forestplot")
library("forestplot")
library(dplyr)
forestplot(labeltext = "Canada", mean = 2.83, lower = 0.75, upper = 10.72)

forestplot(labeltext = data$country.name, mean = c(1,1,1,1,1), lower = data$lower.CI, upper = data$upper.CI)
data$country.name <- as.factor(data$country.name)


#using ggplot2
library(tidyverse)
library(gt)
library(ggplot2)

help(fct_rev)
p <- 
  data |>
  ggplot(aes(y = fct_rev(country.name))) + 
  theme_classic() +
  geom_point(aes(x=data$HR), shape=15, size=3) +
  geom_linerange(aes(xmin=data$lower.CI, xmax=data$upper.CI)) +
  scale_x_continuous(breaks=seq(0,11,by=2)) +
  geom_vline(xintercept = 2, linetype="dashed") +
  labs(title = "Hazard Ratio of Covid-19 Infection for Surgical Masks vs.Respirator", x="Hazard Ratio (95% CI)", y="Country") +
  coord_cartesian(ylim=c(1,5), xlim=c(0, 11)) +
  annotate("text", x = 1.80, y = 0.5, label = "HR = 2") 
p
  
help(labs)


p <- 
  data |>
  ggplot(aes(y = fct_rev(country.name))) + 
  theme_classic() +
  geom_point(aes(x=log(data$HR)), shape=15, size=3) +
  geom_linerange(aes(xmin=log(data$lower.CI), xmax=log(data$upper.CI))) +
  geom_vline(xintercept = log(2), linetype="dashed") +
  geom_vline(xintercept = 0, linetype="solid") +
  labs(title = "Hazard Ratio of Covid-19 Infection for Surgical Masks vs.Respirator", x="Log Hazard Ratio", y="Country") +
  coord_cartesian(ylim=c(1,5), xlim=c(-2, 4)) +
  annotate("text", x = log(2), y = 0.5, label = "HR = 2")
p


