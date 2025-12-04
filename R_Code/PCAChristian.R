#Import dataset and do not attach
newdataset<-AnnePERF[,10:13]
#1. Analysis of centered and scaled data
library (stats)
prc <- prcomp (newdataset, center = T, scale = T)

#2. To see the proportion of variance explained by each principal component
summary(prc) 
# Importance of components:
#                        PC1    PC2    PC3    PC4
# Standard deviation     1.3737 1.0619 0.9256 0.3583
# Proportion of Variance 0.4718 0.2819 0.2142 0.0321
# Cumulative Proportion  0.4718 0.7537 0.9679 1.0000

#3. Decide on how many principal components you should keep using the Keiser criteria:
prc$sdev^2 # eigenvalues for each principal component (PC)
# [1] 1.8871592 1.1277080 0.8567475 0.1283853
# If the eigenvalue of each component is greater than 1, keep that PC

#PC1 and PC2 are the only components greater than 1 
#PC1 (Principal component 1 explains 47.18% of variance 
#in the response variables.
#PC2 (Principal Component 2) explains 28.19% of variance
#in the response variables.
#PC1+PC2 together explain 75.37% of the variance in the response variables. 

#4.Understand the meaning of each principal component (PC):
prc$rotation[,1:2]
#                PC1         PC2
# Log.BMI.     -0.0206585 -0.73047851
# EyeSizemm     0.7021324 -0.03506478
# Log.IntPara.  0.1512038  0.66918270
# Log.Brain.    0.6955004 -0.13178059

#Assess Visually:
biplot(prc,cex=c(0.5,0.7))