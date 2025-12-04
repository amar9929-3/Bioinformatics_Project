#Import dataset and do not attach
newdataset<-MarcusPERF[,3:6]
#1. Analysis of centered and scaled data
library (stats)
prc <- prcomp (newdataset, center = T, scale = T)
#2. To see the proportion of variance explained by each principal component
summary(prc) 
# Importance of components:
#                       PC1    PC2    PC3     PC4
#Standard deviation     1.3430 1.0612 0.8592 0.57626
#Proportion of Variance 0.4509 0.2815 0.1846 0.08302
#Cumulative Proportion  0.4509 0.7324 0.9170 1.00000

#3. Decide on how many principal components you should keep using the Keiser criteria:
prc$sdev^2 # eigenvalues for each principal component (PC)
#[1] 1.8035862 1.1260922 0.7382449 0.3320766
# If the eigenvalue of each component is greater than 1, keep that PC

#PC1, PC2 are the only components greater than 1 
#PC1 (Principal component 1 explains 45.09% of variance 
#in the response variables.
#PC2 (Principal Component 2) explains 28.15% of variance
#in the response variables.
#PC1+PC2 together explain 73.24% of the variance in the response variables. 

#4.Understand the meaning of each principal component (PC):
prc$rotation[,1:2]
#            PC1        PC2
# Log.BMI.  0.4175014 -0.7126618
# L_initial 0.6624384 -0.1434254
# a_initial 0.3930047  0.6085234
# b_initial 0.4820947  0.3181849

#Assess Visually:
biplot(prc,cex=c(0.5,0.7))

