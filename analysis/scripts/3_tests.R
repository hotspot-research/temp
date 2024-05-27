#' ---
#' title: Statistical tests
#' ---
library(dplyr)
library(lawstat)
library(rstatix)
library(rcompanion)

# load the data
respondents <- read.csv("data/respondents.csv")
results <- read.csv("data/results.csv")

results$variant <- as.factor(results$variant)
respondents$variant <- as.factor(respondents$variant)
results$task <- as.factor(results$task)

# define columns
results_numeric <- c("time", "pathLength", "issuesCount", "clicks",
                     "deadClicks")
results_scales <- c("ease", "lostness")
results_categorical <- c("success", "issuesReported")


# check normality
norm_results <- data.frame()
for (column in c(results_numeric, results_scales)) {
  norm_results <- rbind(norm_results, data.frame(
    feature = column,
    interactive = shapiro.test(results[results$variant == "interactive",
                                       column])$p.value,
    int1 = shapiro.test(results[(results$variant == "interactive") &
                                  (results$task == 1), column])$p.value,
    int2 = shapiro.test(results[(results$variant == "interactive") &
                                  (results$task == 2), column])$p.value,
    int3 = shapiro.test(results[(results$variant == "interactive") &
                                  (results$task == 3), column])$p.value,
    noninteractive = shapiro.test(results[results$variant == "non-interactive",
                                          column])$p.value,
    nonint1 = shapiro.test(results[(results$variant == "non-interactive") &
                                     (results$task == 1), column])$p.value,
    nonint2 = shapiro.test(results[(results$variant == "non-interactive") &
                                     (results$task == 2), column])$p.value,
    nonint3 = shapiro.test(results[(results$variant == "non-interactive") &
                                     (results$task == 3), column])$p.value
  ))
}
for (column in c("time", "umux")) {
  norm_results <- rbind(norm_results, data.frame(
    feature = column,
    interactive = shapiro.test(respondents[respondents$variant
                                           == "interactive",
                                           column])$p.value,
    int1 = NA, int2 = NA, int3 = NA,
    noninteractive = shapiro.test(respondents[respondents$variant
                                              == "non-interactive",
                                              column])$p.value,
    nonint1 = NA, nonint2 = NA, nonint3 = NA
  ))
}
write.csv(norm_results, "results/normality.csv", row.names = FALSE)

mann_results <- data.frame()

my_mann <- function(data, column) {
  lev <- levene.test(data[, column],
                     data$variant)
  res <- wilcox_test(data, as.formula(paste0(column, "~variant")),
                     detailed = TRUE)[, c(2, 1, 5, 6, 7, 8, 9, 10)]
  eff <- wilcox_effsize(data, as.formula(paste0(column, "~variant")),
                        detailed = TRUE)
  res$effsize <- eff$effsize[1]
  res$magnitude <- eff$magnitude[1]
  res$z <- wilcoxonZ(
    subset(data[, column], data$variant == "interactive"),
    subset(data[, column], data$variant == "non-interactive")
  )
  res$leveneP <- lev$p.value
  names(res)[names(res) == ".y."] <- "feature"
  return(res)
}

for (column in c(results_numeric, results_scales)) {
  res <- my_mann(results, column)
  res$task <- NA
  mann_results <- rbind(mann_results, res)
  for (task in c(1, 2, 3)) {
    res <- my_mann(results[results$task == task, ], column)
    res$task <- task
    mann_results <- rbind(mann_results, res)
  }
}
for (column in c("time", "umux")) {
  res <- my_mann(respondents, column)
  res$task <- NA
  mann_results <- rbind(mann_results, res)
}
names(mann_results)
write.csv(mann_results, "results/mann-whitney.csv", row.names = FALSE)

chi_results <- data.frame()

my_chi <- function(data, column, by) {
  test <- chisq.test(data[, column], data[, by])
  res <- data.frame(
    feature = column,
    p = test$p.value,
    Xsquared = as.numeric(test$statistic),
    df = as.numeric(test$parameter),
    n = length(data[, column]),
    cramerV = as.numeric(cramerV(table(data[, by], data[,column])))
  )
  return(res)
}
# Chi2 tests
for (column in results_categorical) {
  res <- my_chi(results, column, "variant")
  res$task <- NA
  chi_results <- rbind(chi_results, res)
  for (task in c(1, 2, 3)) {
    res <- my_chi(results[results$task == task, ], column, "variant")
    res$task <- task
    chi_results <- rbind(chi_results, res)
  }
}

# clicks outside of hotspots chi2
data <- matrix(data = c(24, 1718, 92, 2439), nrow = 2, ncol = 2)
test <- chisq.test(data)
chi_results <- rbind(chi_results, data.frame(
  feature = "outsideClicks",
  p = test$p.value,
  Xsquared = as.numeric(test$statistic),
  df = as.numeric(test$parameter),
  cramerV = as.numeric(cramerV(data)),
  n = sum(data),
  task = NA
))
write.csv(chi_results, "results/chi2.csv", row.names = FALSE)

chi_results_2 <- data.frame()

test <- chisq.test(c(24, 92))
chi_results_2 <- rbind(chi_results_2, data.frame(
  feature = "outsideClicks",
  p = test$p.value,
  Xsquared = as.numeric(test$statistic),
  df = as.numeric(test$parameter),
  cohenW = as.numeric(cohenW(c(24, 92), p = c(.5, .5))),
  n = sum(c(24, 92)),
  task = NA
))

tasks <- list(c(11, 45), c(7, 29), c(6, 18))
for(task in seq(3)){
  temp <- unlist(tasks[task])
  test <- chisq.test(temp)
  chi_results_2 <- rbind(chi_results_2, data.frame(
    feature = "outsideClicks",
    p = test$p.value,
    Xsquared = as.numeric(test$statistic),
    df = as.numeric(test$parameter),
    cohenW = as.numeric(cohenW(temp, p = c(.5, .5))),
    n = sum(temp),
    task = task
  ))
}

write.csv(chi_results_2, "results/chi2_fit.csv", row.names = FALSE)
