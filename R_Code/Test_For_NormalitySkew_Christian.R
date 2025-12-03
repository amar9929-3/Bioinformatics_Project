
setwd("C:/Users/lamoo/Downloads")
df <- read.csv("Anne_3.3.csv")

#install.packages(c("moments", "car"))
library(moments)
library(car)

vars <- c("BMI", "EyeSizemm", "InternalParasite",	"BrainWeightg")   # or your second dataset variables

str(df)
df$InternalParasite. <- as.numeric(as.character(df$InternalParasite.))
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


