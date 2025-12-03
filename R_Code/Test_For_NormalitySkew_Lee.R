
setwd("C:/Users/lamoo/Downloads")
df <- read.csv("Lee_3.1.csv")

install.packages(c("moments", "car"))
library(moments)
library(car)

vars <- c("BMI", "L_initial", "a_initial", "b_initial")   # or your second dataset variables

# Loop through each variable
for (v in vars) {
  cat("\n====================\n")
  cat("Variable:", v, "\n")
  cat("====================\n")
  
  # Normality Test
  cat("Shapiro-Wilk Normality Test:\n")
  print(shapiro.test(df[[v]]))
  
  # Skewness
  cat("\nSkewness:\n")
  print(skewness(df[[v]], na.rm = TRUE))
  
  cat("\n\n")
}
