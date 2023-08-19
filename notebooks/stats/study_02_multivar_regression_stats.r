# Before starting, make sure you have opened a new terminal and typed: radian
# To run the entire script, type: Ctrl+Shift+S, for one line simply Ctrl+Enter
# To modify linter try this page: https://lintr.r-lib.org/articles/lintr.html#configuring-linters

# Study 02 data series

# Site used to create these analyses
# https://medium.com/analytics-vidhya/multiple-linear-regression-factor-analysis-in-r-35a26a2575cc
# https://stats.oarc.ucla.edu/r/dae/logit-regression/

# Here we are conducting a t-test for the correlation coefficient. We compute the partial correlation 
# coefficients along with the t-statistics and corresponding p-values for each independent variable.

# If we get a high 'pearson pairwise coorelation coefficient' and 'p-value' then we can safely assume 
# that there is a high degree of collinearity between the independent variables.



### INSTALLING PACKAGES ###
# if you see the version is out of date, run: update.packages()

# install.packages("readxl")
# install.packages("discribe")
# install.packages("corrplot")
# install.packages("RColorBrewer")
# install.packages("ppcor")
# install.packages("car")
# install.packages("psych")
# install.packages("aod")
# install.packages("ggplot2")
# install.packages("ggcorrplot")

### LOADING PACKAGES ###
# Loading packages
library("readxl")
library("corrplot")
library("RColorBrewer")
library("ppcor")
library("car")
library("psych")
library("aod")
library("ggplot2")
library("ggcorrplot")


### CHANGE DIRECTORY ###
setwd("/Users/liamroy/Documents/")
getwd() 



# STATE: 0 (Stuck)  //  SECTION: 2X (Uninformed)
regression_st0_sect2X_data <- read_excel("response_book.xlsx", sheet="regression_st0_sect2X", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)

head(regression_st0_sect2X_data)
dim(regression_st0_sect2X_data)
str(regression_st0_sect2X_data)
names(regression_st0_sect2X_data)

trimmed_regression_st0_sect2X_data <- subset(regression_st0_sect2X_data, select = -c(1, 3))

summary(trimmed_regression_st0_sect2X_data)
sapply(trimmed_regression_st0_sect2X_data, sd)

trimmed_regression_st0_sect2X_datamatrix<-cor(trimmed_regression_st0_sect2X_data)

title <- 'Section 2X: Uninformed Initialization \nCorrelation Matrix State 0: Stuck'
corrplot(trimmed_regression_st0_sect2X_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st0_sect2X_data, method = "pearson")

#Regression Model
model_st0_sect2X = lm(Correct~., trimmed_regression_st0_sect2X_data)
summary(model_st0_sect2X)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st0_sect2X)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st0_sect2X_data$Correct <- factor(trimmed_regression_st0_sect2X_data$Correct)
trimmed_regression_st0_sect2X_data$'P1_BPM' <- factor(trimmed_regression_st0_sect2X_data$'P1_BPM')
trimmed_regression_st0_sect2X_data$'P2_BPL' <- factor(trimmed_regression_st0_sect2X_data$'P2_BPL')
trimmed_regression_st0_sect2X_data$'P3_Pitch' <- factor(trimmed_regression_st0_sect2X_data$'P3_Pitch')

head(trimmed_regression_st0_sect2X_data)

st0_sect2X_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st0_sect2X_data, family = "binomial")
summary(st0_sect2X_logit, list.len = ncol(trimmed_regression_st0_sect2X_data))





# STATE: 1 (Accomplished)  //  SECTION: 2X (Uninformed)
regression_st1_sect2X_data <- read_excel("response_book.xlsx", sheet="regression_st1_sect2X", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)


head(regression_st1_sect2X_data)
dim(regression_st1_sect2X_data)
str(regression_st1_sect2X_data)
names(regression_st1_sect2X_data)

trimmed_regression_st1_sect2X_data <- subset(regression_st1_sect2X_data, select = -c(1, 3))

summary(trimmed_regression_st1_sect2X_data)
sapply(trimmed_regression_st1_sect2X_data, sd)

trimmed_regression_st1_sect2X_datamatrix<-cor(trimmed_regression_st1_sect2X_data)

title <- 'Section 2X: Uninformed Initialization \nCorrelation Matrix State 1: Accomplished'
corrplot(trimmed_regression_st1_sect2X_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st1_sect2X_data, method = "pearson")

#Regression Model
model_st1_sect2X = lm(Correct~., trimmed_regression_st1_sect2X_data)
summary(model_st1_sect2X)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st1_sect2X)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st1_sect2X_data$Correct <- factor(trimmed_regression_st1_sect2X_data$Correct)
trimmed_regression_st1_sect2X_data$'P1_BPM' <- factor(trimmed_regression_st1_sect2X_data$'P1_BPM')
trimmed_regression_st1_sect2X_data$'P2_BPL' <- factor(trimmed_regression_st1_sect2X_data$'P2_BPL')
trimmed_regression_st1_sect2X_data$'P3_Pitch' <- factor(trimmed_regression_st1_sect2X_data$'P3_Pitch')

head(trimmed_regression_st1_sect2X_data)

st1_sect2X_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st1_sect2X_data, family = "binomial")
summary(st1_sect2X_logit, list.len = ncol(trimmed_regression_st1_sect2X_data))





# STATE: 2 (Progressing)  //  SECTION: 2X (Uninformed)
regression_st2_sect2X_data <- read_excel("response_book.xlsx", sheet="regression_st2_sect2X", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)


head(regression_st2_sect2X_data)
dim(regression_st2_sect2X_data)
str(regression_st2_sect2X_data)
names(regression_st2_sect2X_data)

trimmed_regression_st2_sect2X_data <- subset(regression_st2_sect2X_data, select = -c(1, 3))

summary(trimmed_regression_st2_sect2X_data)
sapply(trimmed_regression_st2_sect2X_data, sd)

trimmed_regression_st2_sect2X_datamatrix<-cor(trimmed_regression_st2_sect2X_data)

title <- 'Section 2X: Uninformed Initialization \nCorrelation Matrix State 2: Progressing'
corrplot(trimmed_regression_st2_sect2X_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st2_sect2X_data, method = "pearson")

#Regression Model
model_st2_sect2X = lm(Correct~., trimmed_regression_st2_sect2X_data)
summary(model_st2_sect2X)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st2_sect2X)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st2_sect2X_data$Correct <- factor(trimmed_regression_st2_sect2X_data$Correct)
trimmed_regression_st2_sect2X_data$'P1_BPM' <- factor(trimmed_regression_st2_sect2X_data$'P1_BPM')
trimmed_regression_st2_sect2X_data$'P2_BPL' <- factor(trimmed_regression_st2_sect2X_data$'P2_BPL')
trimmed_regression_st2_sect2X_data$'P3_Pitch' <- factor(trimmed_regression_st2_sect2X_data$'P3_Pitch')

head(trimmed_regression_st2_sect2X_data)

st2_sect2X_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st2_sect2X_data, family = "binomial")
summary(st2_sect2X_logit, list.len = ncol(trimmed_regression_st2_sect2X_data))



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# STATE: 0 (Stuck)  //  SECTION: 2O (Informed)
regression_st0_sect2O_data <- read_excel("response_book.xlsx", sheet="regression_st0_sect2O", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)


head(regression_st0_sect2O_data)
dim(regression_st0_sect2O_data)
str(regression_st0_sect2O_data)
names(regression_st0_sect2O_data)

trimmed_regression_st0_sect2O_data <- subset(regression_st0_sect2O_data, select = -c(1, 3))

summary(trimmed_regression_st0_sect2O_data)
sapply(trimmed_regression_st0_sect2O_data, sd)

trimmed_regression_st0_sect2O_datamatrix<-cor(trimmed_regression_st0_sect2O_data)

title <- 'Section 2O: Uninformed Initialization \nCorrelation Matrix State 0: Stuck'
corrplot(trimmed_regression_st0_sect2O_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st0_sect2O_data, method = "pearson")

#Regression Model
model_st0_sect2O = lm(Correct~., trimmed_regression_st0_sect2O_data)
summary(model_st0_sect2O)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st0_sect2O)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st0_sect2O_data$Correct <- factor(trimmed_regression_st0_sect2O_data$Correct)
trimmed_regression_st0_sect2O_data$'P1_BPM' <- factor(trimmed_regression_st0_sect2O_data$'P1_BPM')
trimmed_regression_st0_sect2O_data$'P2_BPL' <- factor(trimmed_regression_st0_sect2O_data$'P2_BPL')
trimmed_regression_st0_sect2O_data$'P3_Pitch' <- factor(trimmed_regression_st0_sect2O_data$'P3_Pitch')

head(trimmed_regression_st0_sect2O_data)

st0_sect2O_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st0_sect2O_data, family = "binomial")
summary(st0_sect2O_logit, list.len = ncol(trimmed_regression_st0_sect2O_data))




# STATE: 1 (Accomplished)  //  SECTION: 2O (Informed)
regression_st1_sect2O_data <- read_excel("response_book.xlsx", sheet="regression_st1_sect2O", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)

head(regression_st1_sect2O_data)
dim(regression_st1_sect2O_data)
str(regression_st1_sect2O_data)
names(regression_st1_sect2O_data)

trimmed_regression_st1_sect2O_data <- subset(regression_st1_sect2O_data, select = -c(1, 3))

summary(trimmed_regression_st1_sect2O_data)
sapply(trimmed_regression_st1_sect2O_data, sd)

trimmed_regression_st1_sect2O_datamatrix<-cor(trimmed_regression_st1_sect2O_data)

title <- 'Section 2O: Uninformed Initialization \nCorrelation Matrix State 1: Accomplished'
corrplot(trimmed_regression_st1_sect2O_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st1_sect2O_data, method = "pearson")

#Regression Model
model_st1_sect2O = lm(Correct~., trimmed_regression_st1_sect2O_data)
summary(model_st1_sect2O)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st1_sect2O)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st1_sect2O_data$Correct <- factor(trimmed_regression_st1_sect2O_data$Correct)
trimmed_regression_st1_sect2O_data$'P1_BPM' <- factor(trimmed_regression_st1_sect2O_data$'P1_BPM')
trimmed_regression_st1_sect2O_data$'P2_BPL' <- factor(trimmed_regression_st1_sect2O_data$'P2_BPL')
trimmed_regression_st1_sect2O_data$'P3_Pitch' <- factor(trimmed_regression_st1_sect2O_data$'P3_Pitch')

head(trimmed_regression_st1_sect2O_data)

st1_sect2O_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st1_sect2O_data, family = "binomial")
summary(st1_sect2O_logit, list.len = ncol(trimmed_regression_st1_sect2O_data))




# STATE: 2 (Progressing)  //  SECTION: 2O (Informed)
regression_st2_sect2O_data <- read_excel("response_book.xlsx", sheet="regression_st2_sect2O", range = "A1:G649", col_names = TRUE, col_types = NULL, na = "", skip = 0)

head(regression_st2_sect2O_data)
dim(regression_st2_sect2O_data)
str(regression_st2_sect2O_data)
names(regression_st2_sect2O_data)

trimmed_regression_st2_sect2O_data <- subset(regression_st2_sect2O_data, select = -c(1, 3))

summary(trimmed_regression_st2_sect2O_data)
sapply(trimmed_regression_st2_sect2O_data, sd)

trimmed_regression_st2_sect2O_datamatrix<-cor(trimmed_regression_st2_sect2O_data)

title <- 'Section 2O: Uninformed Initialization \nCorrelation Matrix State 2: Progressing'
corrplot(trimmed_regression_st2_sect2O_datamatrix, method ="circle", type="upper", title=title, 
            col=brewer.pal(n=8, name="PRGn"), tl.col="black", tl.srt=45, 
            addCoef.col = 1, number.cex = 0.8, mar=c(0,0,3,0))

pcor(trimmed_regression_st2_sect2O_data, method = "pearson")

#Regression Model
model_st2_sect2O = lm(Correct~., trimmed_regression_st2_sect2O_data)
summary(model_st2_sect2O)

# Check Variable Inflation Factor (VIF). High Variable Inflation Factor (VIF) is a sign of multicollinearity.
# If VIF is greater than 2.5, then multicollinearity is a problem.
vif(model_st2_sect2O)


# We want to convert ____ to a factor to indicate that it is a categorical variable
trimmed_regression_st2_sect2O_data$Correct <- factor(trimmed_regression_st2_sect2O_data$Correct)
trimmed_regression_st2_sect2O_data$'P1_BPM' <- factor(trimmed_regression_st2_sect2O_data$'P1_BPM')
trimmed_regression_st2_sect2O_data$'P2_BPL' <- factor(trimmed_regression_st2_sect2O_data$'P2_BPL')
trimmed_regression_st2_sect2O_data$'P3_Pitch' <- factor(trimmed_regression_st2_sect2O_data$'P3_Pitch')

head(trimmed_regression_st2_sect2O_data)

st2_sect2O_logit <- glm(Correct~ P1_BPM + P2_BPL + P3_Pitch + Confidence, data = trimmed_regression_st2_sect2O_data, family = "binomial")
summary(st2_sect2O_logit, list.len = ncol(trimmed_regression_st2_sect2O_data))
