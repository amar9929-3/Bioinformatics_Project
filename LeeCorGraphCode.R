#Correlations/Justifications of why we merged values

###Lee_Dataset; Length-Weight######
# Test: 
# V1: Length
# V2: Weight
#Test: We will run a correlation test. 
#This is because there is no implied causality between the two variables
#and neither variable has been set (they are both measured).
#There is no distinction between DV and IV.
#We want to investigate the degree to which the variables co-vary.

attach(Marcus2.0.copy)
library(car)
library (lme4)
#Create scatter plot to see if the assumptions are met 
#Check if the two parametric assumptions are met: 1) Linearity 2)Normality
#1) Linearity
scatterplot(Lengthmm,Weightg)
#There are not points on either side of the trend line
#The shaded region does not encompasses the entirety of the trend line
#So,the data does not meets the linearity assumption. 

#2) Normality
#The box plots don't appear normal

# shapiro.test(Lengthmm)
# 
# data:  Lengthmm
# W = 0.93302, p-value = 1.621e-10

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
# W = 0.98086, p-value = 0.0004128
#The P-value is below 0.05 so Length (variable one) 
#fails the Shapiro-Wilk test.

shapiro.test (log10(Weightg))
# Shapiro-Wilk normality test
# 
# data:  log10(Weightg)
# W = 0.93302, p-value = 1.621e-10
#The P-value is below 0.05 so weight (variable two) 
#fails the Shapiro-Wilk test.

#All assumptions are not met with a log transformation 
#I will run a non parametric spearmans to get 
#tau. But, still translate that to the R and R^2
#for transferability to comparison (to Christian dataset) as long as
#the rho value still shows strong correlation. 
cor.test(Lengthmm,Weightg,method='spearman')
# Spearman's rank correlation rho
# 
# data:  Lengthmm and Weightg
# S = 0, p-value < 2.2e-16
# alternative hypothesis: true rho is not equal to 0
# sample estimates:
# rho 
#   1 
#rho is highly correlated. 
#So, I will do a Pearson's Correlation with transformed data 

cor.test (log10(Lengthmm), log10(Weightg))
# Pearson's product-moment correlation
# 
# data:  log10(Lengthmm) and log10(Weightg)
# t = 111.82, df = 304, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   0.9850677 0.9904566
# sample estimates:
#   cor 
# 0.9880606  
#The estimated correlation coefficient (r) is 0.9880606 . 
#This number is closer to 1 than 0 or -1.
#So, the variables are highly correlated. 

#I have 95% confidence that the true correlation 
#coefficient between Length and weight
#is in the interval[0.9850677 0.9904566].


#Visualize Data for report
library(ggplot2)

#Log-transform variables for graph
Marcus2.0.copy$log_Length <- log10(Marcus2.0.copy$Lengthmm)
Marcus2.0.copy$log_Weight <- log10(Marcus2.0.copy$Weightg)
#Pearson correlation test 
cor_test <- cor.test(Marcus2.0.copy$log_Length, Marcus2.0.copy$log_Weight)
# For both to be on graph, extract r and R^2
r_value <- cor_test$estimate
r2_value <- r_value^2
#Annotation labels
r_label  <- paste0("italic(r) == ", round(r_value, 3))
r2_label <- paste0("italic(R)^2 == ", round(r2_value, 3))
#Positioning the lables
x_pos <- min(Marcus2.0.copy$log_Length, na.rm = TRUE) + 0.05
y_pos <- max(Marcus2.0.copy$log_Weight, na.rm = TRUE) - 0.05
#Good graph
ggplot(Marcus2.0.copy, aes(x = log_Length, y = log_Weight)) +
  geom_point(color = "green4", size = 2.0, alpha = 0.7) +
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
    subtitle = "                                                                  Lee Dataset",
    x = expression(log[10]("Total Length [mm]")),
    y = expression(log[10]("Weight [g]"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    plot.subtitle = element_text(face = "bold", color = "green4")
  )
detach(Marcus2.0.copy)
