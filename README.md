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
## Steps for Reproducibility
- Data was preprocessed (Christian: Anne 3.3.csv; Lee: Lee_3.1.csv)
- Preprocessed data was tested for skewness in their respective R code ("Test_For_NormalitySkew_Lee.R" and "Test_For_NormalitySkew_Christian.R") to determine necessary log transformations. 
- Preprocessed data was run through respective CoLab notebooks to generate simulated data that will be used for ML training
  - Christian: "Anne 3.3.csv" run through "Simulate_Data_Christian.ipynb" to obtain "simulated_group_conditoned.csv".
  - Lee: "Lee_3.1.csv" run through "Simulate_Data_Lee.ipynb" to obtain "simulated_Lee.csv".
- Simulated data was imported into the respective ML notebook ("ML_Christian_Finished.ipynb"; "ML_Lee_Finished.ipynb") and train/test split so that 85% would be used for unsupervised method visualization and ML training, and 15% would later be used to test the accuracy of the trained models.
  - Drop unwanted columns and set predictor variable (Christian: Drop '@#', 'River', 'Predation', 'Population', 'Lengthmm', 'Weightg'. Predict 'Population'); (Lee: Drop 'Population'. 'Population').
  - Train and test split with test size of 0.15
- Define which columns need certain tranformations and how to transform them (later used in supervised model pipelines). If and how variables were transformed was determined by R codes "Test_For_NormalitySkew_Lee.R" and "Test_For_NormalitySkew_Christian.R". 
  - Christian: Log transform "BMI" and "BrainWeightg". Log(x+1) transform "InternalParasite#". 
  - Lee: Log transform "BMI"
- Log transform for unsupervised vis:
- Unsupervised model plots:
- Build and train supervised pipelines:
- Confusion matrix of best model:
- Cross validate training:
- ROC curves:
- Trained color coded UMAP:
- Import real data:
- split real data:
- Run real data on best model and get accuracy and roc auc results: 
