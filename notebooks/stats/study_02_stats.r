# Before starting, make sure you have opened a new terminal and typed: radian
# To run the entire script, type: Ctrl+Shift+S, for one line simply Ctrl+Enter
# To modify linter try this page: https://lintr.r-lib.org/articles/lintr.html#configuring-linters

# Study 02 data series
jackal_before_condA <- c(3, 2, 1, 1, 2, 3, 2, 1, 3, 2, 0, 3) # nolint
jackal_before_condB <- c(3, 0, 2, 2, 3, 2, 1, 3, 1, 2, 2, 2) # nolint
jackal_before_all <- c(3, 2, 1, 1, 2, 3, 2, 1, 3, 2, 0, 3, 3, 0, 2, 2, 3, 2, 1, 3, 1, 2, 2, 2) # nolint

spot_before_condA <- c(3, 1, 3, 2, 1, 2, 0, 1, 3, 2, 1, 3) # nolint
spot_before_condB <- c(3, 3, 3, 2, 2, 3, 2, 3, 2 ,1 ,3, 3) # nolint
spot_before_all <- c(3, 1, 3, 2, 1, 2, 0, 1, 3, 2, 1, 3, 3, 3, 3, 2, 2, 3, 2, 3, 2 ,1 ,3, 3) # nolint

jackal_after_condA <- c(3, 3, 3, 2, 3, 3, 1, 3, 3, 3, 3, 3) # nolint
jackal_after_condB <- c(3, 2, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3) # nolint

spot_after_condA <- c(3, 3, 3, 3, 3, 3, 1, 3, 3, 3, 3, 3) # nolint
spot_after_condB <- c(3, 3, 2, 1, 3, 3, 3, 3, 3, 3, 1, 3) # nolint

steps_to_conv_sect2X_condA <- c(36, 38, 43, 42, 41, 36, 43, 38, 39, 36, 41, 36) # nolint
steps_to_conv_sect2X_condB <- c(36, 41, 36, 59, 36, 41, 42, 36, 36, 60, 36, 36) # nolint

steps_to_conv_sect2O_condA <- c(12, 10, 15, 12, 20, 11, 40, 15, 12, 10, 18, 12) # nolint
steps_to_conv_sect2O_condB <- c(10, 14, 11, 58, 11, 15, 23, 11, 19, 21, 9, 13) # nolint





# Study 02 Wilcoxon Rank Sum and Signed Rank Stats Analyses


# TEST 1: Jackal Accuracy before-after (section 1A and section 3A) under condA
# Expect: significant improvement 
jackal_accuracy_condA <- data.frame(value = c(jackal_before_condA,jackal_after_condA), 
                  condition = rep(c("jackal_before_condA","jackal_after_condA"), each=12))
boxplot(value ~ condition, data = jackal_accuracy_condA, col = "#00b324", main = "Identified states with Jackal [before]~[after] training under condA", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = jackal_accuracy_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 2: Jackal Accuracy before-after (section 1A and section 3A) under condB
# Expect: significant improvement 
jackal_accuracy_condB <- data.frame(value = c(jackal_before_condB,jackal_after_condB), 
                  condition = rep(c("jackal_before_condB","jackal_after_condB"), each=12))
boxplot(value ~ condition, data = jackal_accuracy_condB, col = "#00b324", main = "Identified states with Jackal [before]~[after] training under condB", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = jackal_accuracy_condB, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 3: Spot Accuracy before-after (section 1B and section 3B) under condA
# Expect: significant improvement 
spot_accuracy_condA <- data.frame(value = c(spot_before_condA,spot_after_condA), 
                  condition = rep(c("spot_before_condA","spot_after_condA"), each=12))
boxplot(value ~ condition, data = spot_accuracy_condA, col = "#00b324", main = "Identified states with Spot [before]~[after] training under condA", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = spot_accuracy_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 4: Spot Accuracy before-after (section 1B and section 3B) under condB
# Expect: significant improvement 
spot_accuracy_condB <- data.frame(value = c(spot_before_condB,spot_after_condB), 
                  condition = rep(c("spot_before_condB","spot_after_condB"), each=12))
boxplot(value ~ condition, data = spot_accuracy_condB, col = "#00b324", main = "Identified states with Spot [before]~[after] training under condB", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = spot_accuracy_condB, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 5: Accuracy between Jackal and Spot (section 1A and section 1B) before training 
# Expect: insignificant
jackal_spot_before <- data.frame(value = c(jackal_before_all,spot_before_all), 
                  condition = rep(c("jackal_before_all","spot_before_all"), each=24))
boxplot(value ~ condition, data = jackal_spot_before, col = "#00b324", main = "Identified states in [jackal]~[spot] before training", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = jackal_spot_before, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 6: Accuracy before training between Jackal and Spot (section 3A and section 3B) under condA
# Expect: insignificant
jackal_spot_after_condA <- data.frame(value = c(jackal_after_condA,spot_after_condA), 
                  condition = rep(c("jackal_after_condA","spot_after_condA"), each=12))
boxplot(value ~ condition, data = jackal_spot_after_condA, col = "#00b324", main = "Identified states in [jackal]~[spot] after training for condA", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = jackal_spot_after_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 7: Accuracy before training between Jackal and Spot (section 3A and section 3B) under condB
# Expect: insignificant
jackal_spot_after_condB <- data.frame(value = c(jackal_after_condB,spot_after_condB), 
                  condition = rep(c("jackal_after_condB","spot_after_condB"), each=12))
boxplot(value ~ condition, data = jackal_spot_after_condB, col = "#00b324", main = "Identified states in [jackal]~[spot] after training for condB", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = jackal_spot_after_condB, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TEST 8: Steps to converge between Jackal and Spot (section 2X no init and section 2O pilot init) under condA
# Expect: significant improvement 
dat_steps_to_conv_condA <- data.frame(value = c(steps_to_conv_sect2O_condA,steps_to_conv_sect2X_condA), 
                  condition = rep(c("steps_to_conv_sect2O_condA","steps_to_conv_sect2X_condA"), each=12))
boxplot(value ~ condition, data = dat_steps_to_conv_condA, col = "#00b324", main = "Steps to converge [sect2X no init]~[sect2O pilot init] for condA", ylab = "Steps", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_steps_to_conv_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)
wilcox.test(steps_to_conv_sect2X_condA, steps_to_conv_sect2O_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)



# TEST 9: Steps to converge between Jackal and Spot (section 2X no init and section 2O pilot init) under condB
# Expect: significant improvement 
dat_steps_to_conv_condB <- data.frame(value = c(steps_to_conv_sect2O_condB,steps_to_conv_sect2X_condB), 
                  condition = rep(c("steps_to_conv_sect2O_condB","steps_to_conv_sect2X_condB"), each=12))
boxplot(value ~ condition, data = dat_steps_to_conv_condB, col = "#00b324", main = "Steps to converge [sect2X no init]~[sect2O pilot init] for condB", ylab = "Steps", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_steps_to_conv_condB, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)
wilcox.test(steps_to_conv_sect2X_condB, steps_to_conv_sect2O_condB, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# TESTING HOW THINGS WORK
# Shorter way to do the test. Your ranked value will end up as the lower of the two in this case.
# wilcox.test(accuracy_before_libA_condA, accuracy_after_libA_condA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)

# test_A <- c(1, 2, 4, 4) # nolint
# test_B <- c(4, 6, 7, 8) # nolint

# dat_testing <- data.frame(value = c(test_A,test_B), 
#                   condition = rep(c("test_A","test_B"), each=4))
# boxplot(value ~ condition, data = dat_testing, col = "#00b324", main = "Testing how Wilcoxon Rank works", ylab = "Values", xlab = "Condition")
# wilcox.test(value ~ condition, data = dat_testing, alternative = "greater", exact = FALSE, conf.int = TRUE, conf.level = 0.95)
# wilcox.test(test_A, test_B, alternative = "greater", exact = FALSE, conf.int = TRUE, conf.level = 0.95)

# W = the number of times that a value in the first sample is larger than a value in the second sample (or vice versa) where ties are broken by assigning 0.5 to each value in the tie.
# The alternative hypothesis can be either two.sided, greater or less. two.sided is the default. 
# If alternative is two.sided, then the null hypothesis is that the two distributions are the same, and the alternative is that they are different. 
# If alternative is less, then the null hypothesis is that the first distribution stochastically dominates the second, and the alternative is that the first distribution does not stochastically dominate the second. 
# If alternative is greater, then the null hypothesis is that the first distribution is stochastically dominated by the second, and the alternative is that the first distribution is not stochastically dominated by the second.