# Bioinformatics_Project
Using Machine Learning to Assess Explanatory Variables Differentiating Population of Origin in Anablepsoides hartii 
## Docs Folder
- "ai_usage.md": Documents and explains ai usage. 
- "Anne 3.3.csv" and "Lee_3.1.csv": Preprocessed real data. 
- "simulated_group_conditoned.csv" and "simulated_Lee.csv": Simulated data used for ML training.
- "Lee Original Data Link": Raw text document that links the original open source data for Lee's dataset. The file is too large to upload to Github, so the link with a DOI is provided instead.
## Notebooks Folder
- Contains all CoLab notebooks used for machine learning (visualization, unsupervised/supervised methods, etc.).
- "ML_Christian_Tester.ipynb" and "ML_Lee.ipynb": Original basic code for ML and visualization that finished notebooks were adapted/edited from.
- "ML_Christian_Finished.ipynb" and "ML_Lee_Finished.ipynb": Final edited code for ML and visualization. Latest commits are completely run notebooks with all figures and results. These notebooks... use unsupervised methods for visualization and trains three machines/pipelines using the simulated data, run evaluation (confusion matrix, cv, roc_auc) on trained pipelines, and uses best trained pipeline on new/real preprocessed data to predict population of origin. 
- "Simulate_Data_Christian.ipynb" and "Simulate_Data_Lee.ipynb": Generates simulated data from the real preprocessed data using parameters (min, max, sample size, etc.). This simulated data obtained from this notebook is used to train the ML. 
## R_Code Folder
- "ChristianCorGraphCode.R": Tests the correlation between length (mm) and weight (g), revealing a positive strong correlation between the two variables. As such, it was decided to merge them into BMI using Fulton's condition factor to eliminate unecessary clustering of the two variables together. This code was also used to create the visual represenatations of correlation used in the report. 
- "LeeCorGraphCode.R": Tests the correlation between length (mm) and weight (g), revealing a positive strong correlation between the two variables. As such, it was decided to merge them into BMI using Fulton's condition factor to eliminate unecessary clustering of the two variables together. This code was also used to create the visual represenatations of correlation used in the report. 
- "Script_Color_Plasticity_Data.R": Adapted from Lee & Walsh (2025) open source code. Takes raw color change data and extracts color change plasticity values. Puts them into a .csv file.
- "Test_For_NormalitySkew_Lee.R": tests variables from Lee dataset for normality and skew to determine if log transformation is necessary.
- "Test_For_NormalitySkew_Christian.R": tests variables from Christian dataset for normality and skew to determine if log transformation is necessary.
- "PCAChristian.R": Runs the code of PCA tests on the Christian dataset. Produces the importance of each criteria and the Keiser component. Produces the accompanying PCA figures.
- "PCALee.R": Runs the code of PCA tests on the Lee dataset. Produces the importance of each criteria and the Keiser component. Produces the accompanying PCA figures. 
## Steps for Reproducibility
- Data was preprocessed (Christian: Anne 3.3.csv; Lee: Lee_3.1.csv)
- Preprocessed data was tested for skewness in their respective R code ("Test_For_NormalitySkew_Lee.R" and "Test_For_NormalitySkew_Christian.R") to determine necessary log transformations. 
- Preprocessed data was run through respective CoLab notebooks to generate simulated data that will be used for ML training
  - Christian: "Anne 3.3.csv" run through "Simulate_Data_Christian.ipynb" to obtain "simulated_group_conditoned.csv".
  - Lee: "Lee_3.1.csv" run through "Simulate_Data_Lee.ipynb" to obtain "simulated_Lee.csv".
- Simulated data was imported into the respective ML notebook ("ML_Christian_Finished.ipynb"; "ML_Lee_Finished.ipynb") and train/test split so that 85% would be used for unsupervised method visualization and ML training, and 15% would later be used to test the accuracy of the trained models.
  - Drop unwanted columns and set predictor variable (Christian: Drop '@#', 'River', 'Predation', 'Population', 'Lengthmm', 'Weightg'. Predict 'Population'); (Lee: Drop 'Population'. Predict 'Population').
  - Train and test split with test size of 0.15
- Define which columns need certain tranformations and how to transform them (later used in supervised model pipelines as make_preprocess). If and how variables were transformed was determined by R codes "Test_For_NormalitySkew_Lee.R" and "Test_For_NormalitySkew_Christian.R". 
  - Christian: Log transform "BMI" and "BrainWeightg". Log(x+1) transform "InternalParasite#". 
  - Lee: Log transform "BMI"
- Define and log transform data that will be used for unsupervised model visualizations (PCA, UMAP, t-SNE)
  - The data transformed here is defined differently from the data that will be used for supervised ML training and will only be used for unsupervised PCA, UMAP, and t-SNE model visualization.
  - Note: This will not impact how the supervised models are trained later. 
- Plot PCA, UMAP, and t-SNE models with a color bar/key that indicates the plotted sample with their respective population.
  - Note: These plots do not impact the supervised ML training that will be done later. 
- Build and train supervised pipelines.
  - Logistic Regression (Log Reg), Random Forest Classifier (RF), and Support Vector Machine (SVM).
  - Each model pipeline includes the previously defined process (make_preprocess) to transform the data as needed.
  - Models are trained and tested on the simulated data (trained on 85% and tested on 15%).
  - Results of accuracy and roc_auc_ovr for each model are printed.
- Run a confusion matrix that shows how the best model predicted the test data and the true population of the data.
  - Print a classification report of the best model. 
- Run cross-validation (cv) with Stratified K-fold on each model to determine best accuracy.
  - Determines how well the trained model may run with new unseen data.
- Plot ROC AUC of the best trained model (plots False and True Positive Rate). 
- Run a color coded UMAP plot that differentiates the train and test data used in the supervised models. 
- Import the real preprocessed data that was used to generate the simulated data.
  - Christian: "Anne 3.3.csv"
  - Lee: "Lee_3.1.csv"
  - Note: The "ML_Christian_Finished.ipynb" and "ML_Lee_Finished.ipynb" CoLabs and the trained models have not seen this data before. 
- Drop unwanted variables and define predicted variable (should be same as what was done with the simulated data).
  - Christian: Drop '@#', 'River', 'Predation', 'Population', 'Lengthmm', 'Weightg'. Predict 'Population'. 
  - Lee: Drop 'Population'. Predict 'Population'.
- Split the real data so that 15% will be used/predicted (sample fraction = 0.15). 
- Run/predict the split real data on the best trained model/pipeline and get accuracy and roc auc results.
- Run the PCA code in R on the data to get the statistics and figure with the lines and how each feature pertains to PC1 and PC2.
  - Christian: "PCAChristian.R"
  - Lee: "PCALee.R"
