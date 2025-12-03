# Bioinformatics_Project
Using Machine Learning to Assess Explanatory Variables Differentiating Population of Origin in Anablepsoides hartii 
## Docs Folder
- "ai_usage.md": Documents and explains ai usage. 
- "Anne 3.3.csv" and "Lee_3.1.csv": Preprocessed real data. 
- "simulated_group_conditoned.csv" and "simulated_Lee.csv": Simulated data used for ML training. 
## Notebooks Folder
- Contains all CoLab notebooks used for machine learning (visualization, unsupervised/supervised methods, etc.).
- "ML_Christian_Tester.ipynb" and "ML_Lee.ipynb": Original basic code for ML and visualization that was adapted/edited.
- "ML_Christian_Finished.ipynb" and "ML_Lee_Finished.ipynb": Final edited code for ML and visualization. Latest commits are completely run notebooks with all figures and results. These notebooks... use unsupervised methods for visualization and trains three machines/pipelines using the simulated data, run evaluation (confusion matrix, cv, roc_auc) on trained pipelines, and uses best trained pipeline on new/real preprocessed data to predict population of origin. 
- "Simulate_Data_Christian.ipynb" and "Simulate_Data_Lee.ipynb": Generates simulated data from the real preprocessed data using parameters (min, max, sample size, etc.). This simulated data obtained from this notebook is used to train the ML. 
## R_Code Folder
- "ChristianCorGraphCode.R":
- "LeeCorGraphCode.R":
- "Script_Color_Plasticity_Data.R":
## Steps for Reproducibility
- Data was preprocessed (Christian: Anne 3.3.csv; Lee: Lee_3.1.csv)
- Preprocessed data was run through respective CoLab notebooks to generate simulated data that will be used for ML training
  - Christian: "Anne 3.3.csv" run through "Simulate_Data_Christian.ipynb" to obtain "simulated_group_conditoned.csv".
  - Lee: "Lee_3.1.csv" run through "Simulate_Data_Lee.ipynb" to obtain "simulated_Lee.csv".
- 
