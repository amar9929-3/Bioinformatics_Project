# Bioinformatics_Project
Using Machine Learning to Assess Explanatory Variables Differentiating Population of Origin in Anablepsoides hartii 
## Docs Folder
- "ai_usage.md": Documents and explains ai usage. 
- "Anne 3.3.csv" and "Lee_3.1.csv": Preprocessed real data. 
- "simulated_group_conditoned.csv" and "simulated_Lee.csv": Simulated data used for ML training.
- "Lee Original Data Link": Raw text document that links the original open source data for Lee's dataset. The file is too large to upload to Github, so the link with a DOI is provided instead.
## Notebooks Folder
- Contains all CoLab notebooks used for machine learning (visualization, unsupervised/supervised methods, etc.).
- "ML_Christian_Tester.ipynb" and "ML_Lee.ipynb": Original basic code for ML and visualization that was adapted/edited.
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
- Preprocessed data was run through respective CoLab notebooks to generate simulated data that will be used for ML training
  - Christian: "Anne 3.3.csv" run through "Simulate_Data_Christian.ipynb" to obtain "simulated_group_conditoned.csv".
  - Lee: "Lee_3.1.csv" run through "Simulate_Data_Lee.ipynb" to obtain "simulated_Lee.csv".
- 
