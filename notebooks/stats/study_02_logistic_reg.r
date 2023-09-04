# Before starting, make sure you have opened a new terminal and typed: radian
# To run the entire script, type: Ctrl+Shift+S, for one line simply Ctrl+Enter
# To modify linter try this page: https://lintr.r-lib.org/articles/lintr.html#configuring-linters

# Study 02 data series

### INSTALLING PACKAGES ###
## if you see the version is out of date, run: update.packages()

# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("cowplot")
### LOADING PACKAGES ###

library("readxl")
library("ggplot2")
library("cowplot")

### CHECK CURRENT DIRECTORY LOCATION
getwd() 

# Load in Data for State 0, Section 2U (Uninformed)
st0_sect2U_data <- read_excel("notebooks/user_data/response_book.xlsx", sheet="regression_st0_sect2U", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)

# Look at the data
head(st0_sect2U_data)

# Remove the first and third column (Value and User ID)
st0_sect2U_data_trim <- subset(st0_sect2U_data, select = -c(1, 3))

# Look at the data structure (see what type of data is in each column)
str(st0_sect2U_data_trim)

# Currently our acoustic parameters are type 'num', we need to modify this
# NOTE: The next lines convert ordinal data to factors (catagorical)
st0_sect2U_data_trim$P1_BPM <- as.factor(st0_sect2U_data_trim$P1_BPM)
st0_sect2U_data_trim$P2_BPL <- as.factor(st0_sect2U_data_trim$P2_BPL)
st0_sect2U_data_trim$P3_Pitch <- as.factor(st0_sect2U_data_trim$P3_Pitch)
# Note, we don't convert the confidence to a factor, since it is a continuous variable


# Replace the binary output for 'Correct' with "Correct" and "Incorrect"
st0_sect2U_data_trim$Correct <- ifelse(test=st0_sect2U_data_trim$Correct == 1, yes="Correct", no="Incorrect")
st0_sect2U_data_trim$Correct <- as.factor(st0_sect2U_data_trim$Correct) # Now convert to a factor

# Look at the data structure again (see what type of data is in each column)
str(st0_sect2U_data_trim)

# Good practice: check that there is a good amount of samples for correct and incorrect responses
table(st0_sect2U_data_trim$Correct)


# Good practice: exclude variables that only have 1 or 2 samples in a category
# since +/- one or two samples can have a large effect on the odds/log(odds)
# We only need to do this for our data that is catagorical (not continuous)
xtabs(~ Correct + P1_BPM, data=st0_sect2U_data_trim)
xtabs(~ Correct + P2_BPL, data=st0_sect2U_data_trim)
xtabs(~ Correct + P3_Pitch, data=st0_sect2U_data_trim)


# Now lets run a logistic regression
# Note: we are using the glm function

# Lets look at the model with all variables
st0_sect2U_logit <- glm(Correct ~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data=st0_sect2U_data_trim, family='binomial')
summary(st0_sect2U_logit)

# Now calculate the overall "Pseudo R-squared" and its p-value
# Note: Since we are doing logistic regression...
#
#     Null devaince = 2*(0 - LogLikelihood(null model))
#                   = -2*LogLikihood(null model)
#
# Residual deviacne = 2*(0 - LogLikelihood(proposed model))
#                   = -2*LogLikelihood(proposed model)
#
# The null model is a model with only an intercept (no predictors)
 
ll.null <- st0_sect2U_logit$null.deviance/-2  # Null model
ll.proposed <- st0_sect2U_logit$deviance/-2   # Model w/ all parameters
 

# McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
# Note: This is a measure of model improvement (not model fit)
#       We can interpret Pseudo R^2 as the % improvement in model fit
(ll.null - ll.proposed) / ll.null


# Chi-square value = 2*(LL(Proposed) - LL(Null))
# p-value = 1 - pchisq(chi-square value, df = 2-1)
1 - pchisq(2*(ll.proposed - ll.null), df=(length(st0_sect2U_logit$coefficients)-1))

# Note that the p-value is so tiny it is essentially zero (p < 0.0001)


# Now plot the data:
# Create a new dataframe that contains the predicted probabilities for each sample
predicted.st0_sect2U_logit <- data.frame(
  probability.of.Correct=st0_sect2U_logit$fitted.values,
  Correct=st0_sect2U_data_trim$Correct)

# Sort the data by the predicted probability
predicted.st0_sect2U_logit <- predicted.st0_sect2U_logit[
  order(predicted.st0_sect2U_logit$probability.of.Correct, decreasing=FALSE),]

# Add a column that contains the index of each sample
predicted.st0_sect2U_logit$rank <- 1:nrow(predicted.st0_sect2U_logit)

# Lastly, plot the predicted probabilities for each sample and colour each sample based on
# whether that sample is actually labeled as 'correct' or 'incorrect' 
ggplot(data=predicted.st0_sect2U_logit, aes(x=rank, y=probability.of.Correct)) +
  geom_point(aes(color=Correct), alpha=1, shape=4, stroke=2) +
  xlab("Data Point Index") +
  ylab("Predicted Probability of Correctly Identified Robot State\n") +
    ggtitle("Logistic Regression for State 0, Section 2U\n") +
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_color_manual(values=c("#40a100", "#ff6600")) +
    theme(legend.title=element_blank()) +
    theme(legend.position="bottom") +
    theme(legend.text=element_text(size=12)) +
    theme(axis.text.x=element_text(size=12)) +
    theme(axis.text.y=element_text(size=12)) +
    theme(axis.title.x=element_text(size=16)) +
    theme(axis.title.y=element_text(size=16)) +
    theme(plot.title=element_text(size=20))
 
 

 # QUESTIONS FOR DANA:
 
 # 1) After doing the regression, we see that parameters P1_BPM and P2_BPL are not significant
      # Can we remove these parameters from the model? Should I re-run this analysis without these parameters?
      # If we remove these parameters, how would we report this in the paper? 
            # (i.e. do we explain that we ran the regression twice, once after removing insignificant parameters?)

# 2) This R script performs a regression for the dataset: State 0 (Stuck), Section U (Uninformed)
     # Let me know if this R script is better. Then I can run the remaining 5 analyses (State 0/1/2, Section U/I)
     # Should I combine the datasets and perform a regression which considers all states together? 
     # Perhaps I could combine State 0/1/2 but keep a separation between Section U/I...
        # This would result in 2 datasets:   Section U, State 0/1/2 
        #                                    Section I, State 0/1/2 
