# Before starting, make sure you have opened a new terminal and typed: radian
# To run the entire script, type: Ctrl+Shift+S, for one line simply Ctrl+Enter
# To modify linter try this page: https://lintr.r-lib.org/articles/lintr.html#configuring-linters



# Study 02 data series
accuracy_before_libA <- c(3, 2, 1, 1, 2, 3, 2, 1, 3, 2, 0, 3, 3, 0, 2, 2, 3, 2, 1, 3, 1, 2, 2, 2) # nolint
accuracy_before_libB <- c(3, 1, 3, 2, 1, 2, 0, 1, 3, 2, 1, 3, 3, 3, 3, 2, 2, 3, 2, 3, 2 ,1 ,3, 3) # nolint
accuracy_after_libA <- c(3, 3, 3, 2, 3, 3, 1, 3, 3, 3, 3, 3, 3, 2, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3) # nolint
accuracy_after_libB <- c(3, 3, 3, 3, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 2, 1, 3, 3, 3, 3, 3, 3, 1, 3) # nolint
accuracy_delta_libA <- c(0, 1, 2, 1, 1, 0, -1, 2, 0, 1, 3, 0, 0, 2, 1, 0, 0, 1, 2, 0, 2, 1, 0, 1) # nolint
accuracy_delta_libB <- c(0, 2, 0, 1, 2, 1, 1, 2, 0, 1, 2, 0, 0, 0, -1, -1, 1, 0, 1, 0, 1, 2, -2, 0) # nolint
steps_to_conv_sect2X <- c(36, 38, 43, 42, 41, 36, 43, 38, 39, 36, 41, 36, 36, 41, 36, 59, 36, 41, 42, 36, 36, 60, 36, 36) # nolint
steps_to_conv_sect2O <- c(12, 10, 15, 12, 20, 11, 40, 15, 12, 10, 18, 12, 10, 14, 11, 58, 11, 15, 23, 11, 19, 21, 9, 13) # nolint




# Study 02 Wilcoxon Rank Sum and Signed Rank Stats Analyses

# Testing libA before-after (section 1 libA and section 3 libA)
# Expect improvement due to algorithm training
dat_libA_accuracy <- data.frame(value = c(accuracy_before_libA,accuracy_after_libA), 
                  condition = rep(c("accuracy_before_libA","accuracy_after_libA"), each=24))
boxplot(value ~ condition, data = dat_libA_accuracy, col = "#00b324", main = "Identified states with libA [before]~[after] training", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_libA_accuracy, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)
wilcox.test(accuracy_before_libA, accuracy_after_libA, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# Testing libB before-after (section 1 libB and section 3 libB)
# Expect improvement due to algorithm training
dat_libB_accuracy <- data.frame(value = c(accuracy_before_libB,accuracy_after_libB), 
                  condition = rep(c("accuracy_before_libB","accuracy_after_libB"), each=24))
boxplot(value ~ condition, data = dat_libB_accuracy, col = "#00b324", main = "Identified states with libB [before]~[after] training", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_libB_accuracy, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# Testing libA and libB before training (section 1 libA and section 1 libB)
# Expect no change to show minor difference in changing sound
dat_sound_before <- data.frame(value = c(accuracy_before_libA,accuracy_before_libB), 
                  condition = rep(c("accuracy_before_libA","accuracy_before_libB"), each=24))
boxplot(value ~ condition, data = dat_sound_before, col = "#00b324", main = "Identified states in [libA]~[libB] before training", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_sound_before, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# Testing libA and libB after training (section 3 libA and section 3 libB)
# Expect no change to show minor difference in changing sound
dat_sound_after <- data.frame(value = c(accuracy_after_libA,accuracy_after_libB), 
                  condition = rep(c("accuracy_after_libA","accuracy_after_libB"), each=24))
boxplot(value ~ condition, data = dat_sound_after, col = "#00b324", main = "Identified states in [libA]~[libB] after training", ylab = "Accuracy", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_sound_after, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# Testing sect2X (no init) and sect2O (pilot init)
# Expect improvement due to initializing with pilot user data
dat_steps_to_conv <- data.frame(value = c(steps_to_conv_sect2O,steps_to_conv_sect2X), 
                  condition = rep(c("steps_to_conv_sect2X","steps_to_conv_sect2O"), each=24))
boxplot(value ~ condition, data = dat_steps_to_conv, col = "#00b324", main = "Steps to converge [sect2X no init]~[sect2O pilot init]", ylab = "Steps", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_steps_to_conv, alternative = "two.sided", exact = FALSE, conf.int = TRUE, conf.level = 0.95)


# TESTING HOW THINGS WORK



test_A <- c(1, 2, 4, 4) # nolint
test_B <- c(4, 6, 7, 8) # nolint

dat_testing <- data.frame(value = c(test_A,test_B), 
                  condition = rep(c("test_A","test_B"), each=4))
boxplot(value ~ condition, data = dat_testing, col = "#00b324", main = "Testing how Wilcoxon Rank works", ylab = "Values", xlab = "Condition")
wilcox.test(value ~ condition, data = dat_testing, alternative = "greater", exact = FALSE, conf.int = TRUE, conf.level = 0.95)
wilcox.test(test_A, test_B, alternative = "greater", exact = FALSE, conf.int = TRUE, conf.level = 0.95)

# W = the number of times that a value in the first sample is larger than a value in the second sample (or vice versa) where ties are broken by assigning 0.5 to each value in the tie.

# The alternative hypothesis can be either two.sided, greater or less. two.sided is the default. 
# If alternative is two.sided, then the null hypothesis is that the two distributions are the same, and the alternative is that they are different. 
# If alternative is less, then the null hypothesis is that the first distribution stochastically dominates the second, and the alternative is that the first distribution does not stochastically dominate the second. 
# If alternative is greater, then the null hypothesis is that the first distribution is stochastically dominated by the second, and the alternative is that the first distribution is not stochastically dominated by the second.