library(tidyverse)
train = read_csv("admit-train.csv")

names(train) 	
# "admit" (acceptance for master course) = 1 means success of admission. 0 does failure.  
# "gre", "gpa" (points in exams): 
	# GRE: Graduate Record Examinations e (200, 800) 10 point increments
	# GPA: Grade Point Average e (2, 4) (4 is best GPA)
# "rank" (rank of bachelor university ) = e (1, ..., 4) 1 point increments (1 is best rank)

summary(train$gre)
summary(train$gpa)
summary(train$rank)
summary(as.factor(train$rank))

# visualize relationships
plot(admit ~ gre, data=train,pch="+")
plot(admit ~ gpa, data=train,pch="+")
plot(admit ~ rank, data=train,pch="+")
table(train$rank,train$admit)
#nominal vs. nominal relationship

# visualize distributions
hist(train$gre, breaks=25)
hist(train$gpa, breaks=18)

## create Logistic Regression model
mylogit = glm(admit ~ gre + gpa + as.factor(rank), data=train, family=binomial(link="logit"))
summary(mylogit)


##	Test the significance of the attribute “rank” using a Wald-Test
install.packages("aod")
library(aod)

wald.test(b=coef(mylogit), Sigma=vcov(mylogit), Terms=4:6)	# similar to F-test in multiple linear regression analysis

## the rank2, 3, 4  are statistically significant because P < 0.05 


##	In order to gain a better understanding of the model, have a look at the 
##  predicted probabilities of some observations. Adjust only one parameter and 
##  keep the others constant. For example keep “gre” and “gpa” constant (using
##  their mean/average) and vary “rank”

rank = c(1,2,3,4)
gre = c(mean(train$gre))
gpa = c(mean(train$gpa))
myinstances = data.frame(gre,gpa,rank)
myinstances

# add predictions to data frame 
myinstances$pAdmit = predict(mylogit, newdata=myinstances, type="response")
myinstances$Admit = predict(mylogit, newdata=myinstances, type="link")
myinstances

## the higher the rank is, the more possibly a student get admitted


##	Find the McFadden ratio and interpret the results:

MCFad = 1 - (mylogit$deviance/mylogit$null.deviance)
MCFad	

##A: the variables can't explain the prediction because it is < 0.2, which is not okay


##	predict the admission in the test dataset

test = read_csv("admit-test.csv") 
preds = predict(mylogit, newdata=test, type='response')
preds

# create confusion matrix as below
table(true=test$admit,prediction=round(preds))


##	calculate the logit model’s error rate

## error rate of Logit-Model ##
incorrectPredictionCount = nrow(test %>% filter(admit!=pred))
totalPredictions = nrow(test)
errorRate = incorrectPredictionCount/totalPredictions
errorRate

##A: 0.3366337