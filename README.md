# Logistic-regression-for-university-admission

In the model, I would like to predict wage, so
- dependent variable is admit
- indepedent variables are gre, gpa, rank

To test the statistical significance in the model, the model's summary states:
- intercept (*** = 0.001 = 0,1% significance level)
- gre (* = 0.05 = 5% significance level)
- gpa (* = 0.05 = 5% significance level)
- rank_3 (*** = 0.001 = 0,1% significance level)
- rank_4 (*** = 0.001 = 0,1% significance level)

The interpretation of the coefficients are:
- as gpa increases by one unit, ODDS of admit rise by a factor of exp(0.920)=2.509
- as the gre score increases by one point, ODDS of being accepted rise by a factor of 1.003 (exp(0.003) = 1.003)
- as rank3 increases by one unit, ODDS of admit fall by a factor of exp(-1.524)=0.218
