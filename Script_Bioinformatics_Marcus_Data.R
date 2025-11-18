#---------------------------------------------------------------------#
#                                                                     #
#   Whole body color analysis script for manuscript:                  #
#   Non-parallel impacts of predators on the evolution                #
#   of colouration plasticity in Trinidadian killifish                #
#                                                                     #
#   Author redacted for Peer Review                                   # 
#   2025/07/03 last edited 2025/08/29                                 #
#                                                                     #
#---------------------------------------------------------------------#


# Clean R environment
rm(list = ls())

# Load the correct libraries
library(car)
library(ggplot2)
library(tidyr)
library(dplyr)
library(MANOVA.RM)
library(adegenet)
library(emmeans)
library(patchwork)
library(cowplot)
library(sf)
library(terra)
library(elevatr)
library(grid)
library(viridis)
library(ggrepel)

# Set your working directory
setwd("C:/Users/lamoo/Downloads")

#Read in csv
dd <- read.csv('all_killifish_colormap_calib.csv')
dd_sex <- read.csv('Killifish_sex_length.csv')
dd_eco <- read.csv('Ecological_variables.csv')

# Check the data 
str(dd)
str(dd_sex)

# Remove the first column (the path to the original file)
dd <- dd[,2:8417]

# Combine the separate files
dd <- merge(dd, dd_sex, by.x = "specimen.factors", by.y = "File", all = FALSE) 
dd <- cbind(dd[,1],dd[,8417:8418],dd[,2:8416])

# Separate out the named column into useful information
dd <- dd %>% 
  separate( `dd[, 1]`, into = c('Type', 'Photo', 'Individual', 'River', 'Predation', 'Background', 'Position'), sep = '_')

# Remove the file extension in the position column
dd$Position <- substr(dd$Position, 1, 1)

# Remove the file extension column
dd <-  dd[, 3:8424]

# Convert the relevant columns to factors
dd[,1:6] <-  lapply(dd[,1:6],as.factor)

# Check the data 
str(dd)

# Remove the juveniles from the dataset but keep them separate as to repeat all analyses with every individual if desired
juv_dd <- dd
dd <- dd[dd$Sex!='J',]

# Split the dataset by if the photo was taken in the field or lab
f_dd <- dd[dd$Position=='F',]
l_dd <- dd[dd$Position=='L',]

# Calculate the number per each sub group
sample_all <-   f_dd %>%
  group_by(River, Predation, Background, Sex) %>%
  summarise(Count=n(),.groups = 'drop')
print(sample_all)

# Averages for the testing of univariate statistics
# R colour channel
selected_columns_r <- dd[, grep("r_", colnames(dd))]
r_mean <- rowMeans(selected_columns_r)

# G color channel
selected_columns_g <- dd[, grep("g_", colnames(dd))]
g_mean <- rowMeans(selected_columns_g)

# B Colour channel
selected_columns_b <- dd[, grep("b_", colnames(dd))]
b_mean <- rowMeans(selected_columns_b)

# Combine into a single dataset
uni_dd <- cbind(dd[,1:7], r_mean, g_mean, b_mean)

# Create a function to convert RGB to CIE L*a*b* colour space
rgb2lab <- function(r, g, b) {
  # Input validation
  if(any(r < 0 | r > 1) || any(g < 0 | g > 1) || any(b < 0 | b > 1)) {
    stop("R, G, B values must be between 0 and 1.")
  }
  
  # Gamma correction (linearize sRGB)
  gamma_correct <- function(c) {
    ifelse(c <= 0.04045,
           c / 12.92,
           ((c + 0.055) / 1.055)^2.4)
  }
  
  r_lin <- gamma_correct(r)
  g_lin <- gamma_correct(g)
  b_lin <- gamma_correct(b)
  
  # sRGB to XYZ conversion matrix (D65)
  X <- r_lin * 0.4124564 + g_lin * 0.3575761 + b_lin * 0.1804375
  Y <- r_lin * 0.2126729 + g_lin * 0.7151522 + b_lin * 0.0721750
  Z <- r_lin * 0.0193339 + g_lin * 0.1191920 + b_lin * 0.9503041
  
  # Scale XYZ by 100
  X <- X * 100
  Y <- Y * 100
  Z <- Z * 100
  
  # Normalize by D65 reference white
  Xn <- 95.047
  Yn <- 100.000
  Zn <- 108.883
  
  x <- X / Xn
  y <- Y / Yn
  z <- Z / Zn
  
  # f(t) helper
  f <- function(t) {
    ifelse(t > 0.008856,
           t^(1/3),
           (7.787 * t) + (16 / 116))
  }
  
  fx <- f(x)
  fy <- f(y)
  fz <- f(z)
  
  # Compute Lab
  L <- (116 * fy) - 16
  a <- 500 * (fx - fy)
  b <- 200 * (fy - fz)
  
  # Return as a named vector
   data.frame(L = L, a = a, b = b)
}

# Use the function on means
LAB <- rgb2lab(uni_dd$r_mean,uni_dd$g_mean,uni_dd$b_mean)

# Combine into a single dataframe
uni_dd <- cbind(uni_dd, LAB)

## Use function for every point
# Extract the RGB matrix
rgb_matrix <- dd[, 8:5056]

# Number of RGB triplets
n_triplets <- ncol(rgb_matrix) / 3

# Sanity check
stopifnot(n_triplets == floor(n_triplets))

# Initialize list to store Lab results
lab_list <- vector("list", n_triplets)

# Loop through each triplet
for (i in seq_len(n_triplets)) {
  cols <- ((i - 1) * 3 + 1):(i * 3)
  r <- rgb_matrix[[cols[1]]]
  g <- rgb_matrix[[cols[2]]]
  b <- rgb_matrix[[cols[3]]]
  
  lab <- rgb2lab(r, g, b)
  
  # Name the columns with a suffix like _1, _2, ...
  colnames(lab) <- paste0(c("L_", "a_", "b_"), i)
  
  lab_list[[i]] <- lab
}

# Combine all Lab triplets into one data frame
lab_converted <- do.call(cbind, lab_list)

# Combine with metadata (first 7 columns)
dd_lab <- cbind(dd[, 1:7], lab_converted)

f_dd_lab <- dd_lab[dd_lab$Position=='F',]
l_dd_lab <- dd_lab[dd_lab$Position=='L',]

# Create a regression between lightness and body size to account for size related differences
size_light_mod <- lm(uni_dd$L~uni_dd$Length)
#plot(size_light_mod)
uni_dd$light_residuals <- size_light_mod$residuals

# Separate dataframe by 1st photo and 2nd
uni_dd_r <- uni_dd[uni_dd$Position=='F',]
uni_dd_l <- uni_dd[uni_dd$Position=='L',]


#---------------------------------------------------------------------#
#                                                                     #
# Question 3 - Is there variation in plasticity?                      #
#                                                                     #
#---------------------------------------------------------------------#

# Calculate the change in average Lightness for each individual 
change_data <- uni_dd_r %>%
  inner_join(uni_dd_l, by = "Individual", suffix = c("_initial", "_final")) %>%
  mutate(
    delta_L = L_final - L_initial,
  )
str(change_data)

# Maximal model
model.p1 <- lm(delta_L ~ River_initial +
                 Background_initial + 
                 Predation_initial +
                 Sex_initial + 
                 River_initial:Background_initial:Predation_initial:Sex_initial +
                 River_initial:Background_initial:Predation_initial +
                 River_initial:Background_initial:Sex_initial +
                 River_initial:Predation_initial:Sex_initial +
                 Predation_initial:Background_initial:Sex_initial +
                 River_initial:Background_initial +
                 River_initial:Sex_initial +      
                 River_initial:Predation_initial +
                 Background_initial:Sex_initial +
                 Predation_initial:Sex_initial +
                 Background_initial:Predation_initial +
                 Length_initial, data=change_data)
summary(model.p1)
Anova(model.p1, type=c('III'))

# Minimal model
model.p1 <- lm(delta_L ~ River_initial +
                 Background_initial + 
                 Predation_initial +
                 Sex_initial + 
                 #River_initial:Background_initial:Predation_initial:Sex_initial +
                 #River_initial:Background_initial:Predation_initial +
                 #River_initial:Background_initial:Sex_initial +
                 #River_initial:Predation_initial:Sex_initial +
                 Predation_initial:Background_initial:Sex_initial +
                 River_initial:Background_initial +
                 River_initial:Sex_initial +      
                 River_initial:Predation_initial +
                 Background_initial:Sex_initial +
                 Predation_initial:Sex_initial +
                 Background_initial:Predation_initial +
                 Length_initial, data=change_data)
summary(model.p1)
Anova(model.p1, type=c('III'))

emm <- emmeans(model.p1, ~ Predation_initial | Sex_initial * Background_initial)
contrast(emm, method = "pairwise", adjust = "tukey")

model.p2.em <- emmeans(model.p1, pairwise ~ River_initial+Predation_initial+Sex_initial+Background_initial, data = change_data, adjust = 'BY')
#write.csv(model.p2.em$contrasts, file = 'contrasts_em_plasticity_review.csv')
plot(model.p2.em)
# Convert the means of the post hoc test into a data frame
indep_means <- as.data.frame(model.p2.em$emmeans)


# Check the delta_L residuals against
delt_mod <- lm(delta_L~Length_initial, data=change_data)
plot(delt_mod)
plot(delta_L~Length_initial, data=change_data)
abline(delt_mod)
change_data$delt_res <- delt_mod$residuals

# Maximal model
model.pres1 <- lm(delt_res ~     River_initial +
                    Background_initial + 
                    Predation_initial +
                    Sex_initial + 
                    #River_initial:Background_initial:Predation_initial:Sex_initial +
                    River_initial:Background_initial:Predation_initial +
                    River_initial:Background_initial:Sex_initial +
                    River_initial:Predation_initial:Sex_initial +
                    Predation_initial:Background_initial:Sex_initial +
                    River_initial:Background_initial +
                    River_initial:Sex_initial +      
                    River_initial:Predation_initial +
                    Background_initial:Sex_initial +
                    Predation_initial:Sex_initial +
                    Background_initial:Predation_initial, data=change_data)
summary(model.pres1)
Anova(model.pres1, type=c('III'))

# minimal model
model.pres2 <- lm(delt_res ~  River_initial +
                    Background_initial + 
                    Predation_initial +
                    Sex_initial + 
                    #River_initial:Background_initial:Predation_initial:Sex_initial +
                    #River_initial:Background_initial:Predation_initial +
                    #River_initial:Background_initial:Sex_initial +
                    #River_initial:Predation_initial:Sex_initial +
                    Predation_initial:Background_initial:Sex_initial +
                    River_initial:Background_initial +
                    River_initial:Sex_initial +      
                    River_initial:Predation_initial +
                    Background_initial:Sex_initial +
                    Predation_initial:Sex_initial +
                    Background_initial:Predation_initial, data=change_data)
summary(model.pres2)
Anova(model.pres2, type=c('III'))

# ------------------------------------------------------------
# CREATE FULL COLOR PLASTICITY DATASET AND EXPORT TO CSV
# ------------------------------------------------------------

# Add delta values for L*, a*, b*
change_data <- change_data %>%
  mutate(
    delta_L = L_final - L_initial,
    delta_a = a_final - a_initial,
    delta_b = b_final - b_initial
  )

# Select clean biologically relevant columns
plasticity_export <- change_data %>%
  select(
    Individual,
    River_initial, Predation_initial, Background_initial, Sex_initial,
    Length_initial,
    L_initial, a_initial, b_initial,
    L_final, a_final, b_final,
    delta_L, delta_a, delta_b
  )

# Export to CSV
write.csv(plasticity_export,
          file = "Killifish_color_plasticity_full.csv",
          row.names = FALSE)

# Optional message
cat("File saved: Killifish_color_plasticity_full.csv\n")

