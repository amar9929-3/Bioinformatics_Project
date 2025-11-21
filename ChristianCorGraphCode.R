#Correlations/Justifications of why we merged values

###Christian_Dataset; Length-Weight###
# Test: 
# V1: Length
# V2: Weight
#Test: We will run a correlation test. 
#This is because there is no implied causality between the two variables
#and neither variable has been set (they are both measured).
#There is no distinction between DV and IV.
#We want to investigate the degree to which the variables co-vary.

attach(Anne3)
library(car)
library (lme4)
#Create scatter plot to see if the assumptions are met 
#Check if the two parametric assumptions are met: 1) Linearity 2)Normality
#1) Linearity
scatterplot(Lengthmm,Weightg)
#There are points on either side of the trend line
#The shaded region does not encompasses the entirety of the trend line
#So,the data does not meets the linearity assumption. 

#2) Normality
#The box plots don't appear normal

shapiro.test(Lengthmm)
# Shapiro-Wilk normality test
# 
# data:  Lengthmm
# W = 0.96705, p-value = 0.0001995
#The P-value is below 0.05 so Length (variable one) 
#fails the Shapiro-Wilk test.

shapiro.test(Weightg)

# Shapiro-Wilk normality test
# 
# data:  Weightg
# W = 0.72792, p-value < 2.2e-16
#The P-value is below 0.05 so weight (variable two) 
#fails the Shapiro-Wilk test.

#Neither assumption is met so I will do a log transformation 
#Linearity of data points on a scatter plot 
#(trendline and lowess smoother useful) 
scatterplot(log10(Lengthmm),log10(Weightg))
#linearity assumption is met w/ log10 transformation
shapiro.test(log10(Lengthmm))

# Shapiro-Wilk normality test
# 
# data:  log10(Lengthmm)
# W = 0.99573, p-value = 0.8748
#The P-value is above 0.05 so length (variable one) 
#passes the Shapiro-Wilk test.
shapiro.test (log10(Weightg))
# Shapiro-Wilk normality test
# 
# data:  log10(Weightg)
# W = 0.99496, p-value = 0.779
#The P-value is above 0.05 so weight (variable two) 
#passes the Shapiro-Wilk test.
#All assumptions are met with a log transformation 
#So, I will do a Pearson's Correlation with transformed data 
cor.test (log10(Lengthmm), log10(Weightg))
# Pearson's product-moment correlation
# 
# data:  log10(Lengthmm) and log10(Weightg)
# t = 98.194, df = 187, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
#     95 percent confidence interval:
#         0.9872792 0.9928209
#     sample estimates:
#       cor 
# 0.9904417 
#The estimated correlation coefficient (r) is 0.9904417 . 
#This number is closer to 1 than 0 or -1.
#So, the variables are highly correlated. 

#I have 95% confidence that the true correlation 
#coefficient between Length and Weight
#is in the interval[0.9872792 0.9928209].


#Visualize Data for report
library(ggplot2)

#Log-transform variables for graph
Anne3$log_Length <- log10(Anne3$Lengthmm)
Anne3$log_Weight <- log10(Anne3$Weightg)
#Pearson correlation test 
cor_test <- cor.test(Anne3$log_Length, Anne3$log_Weight)
#For both to be on graph, extract r and R^2
r_value <- cor_test$estimate
r2_value <- r_value^2
#Annotation labels
r_label  <- paste0("italic(r) == ", round(r_value, 3))
r2_label <- paste0("italic(R)^2 == ", round(r2_value, 3))
#Positioning the labels 
x_pos <- min(Anne3$log_Length, na.rm = TRUE) + 0.05
y_pos <- max(Anne3$log_Weight, na.rm = TRUE) - 0.05
#Good graph
ggplot(Anne3, aes(x = log_Length, y = log_Weight)) +
  geom_point(color = "magenta4", size = 2.0, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 0.9) +
  
  # Add correlation + R2
  annotate("text", x = x_pos, y = y_pos,
           label = r_label, parse = TRUE,
           hjust = 0, size = 5) +
  annotate("text", x = x_pos, y = y_pos - 0.15,
           label = r2_label, parse = TRUE,
           hjust = 0, size = 5) +
  
  labs(
    title = "  Correlation Between Length and Weight (Log-Transformed)",
    subtitle = "                                                                  Christian Dataset",
    x = expression(log[10]("Total Length [mm]")),
    y = expression(log[10]("Weight [g]"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.subtitle = element_text(face = "bold", color = "magenta4")
  )


detach(Anne3)

