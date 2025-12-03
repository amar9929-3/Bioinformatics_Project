# AI Use Log
- Tool/model & version:
- What I asked for:
- Snippet of prompt(s):
- What I changed before committing:
- How I verified correctness (tests, sample data):
## Unsupervised Methods
- Tool: ChatGPT; GPT-4
- Asked: A code to import a .csv file that can be used to run and plot unsupervised methods (PCA, UMAP, and t-SNE); add color coding by population category; small error fixes
- Snippet: How can I write a code in python to import a .csv file and run a PCA, UMAP, and t-SNE that will be used in unsupervised machine learning; how do I have the plot points color coded by their population category; why did I get this error message
- Changed: Names/features to dataset column names; color bar name; csv file upload name
- Verified: run code to see if it fully ran and plots were outputted
## Simulated Data
 - Tool: ChatGPT; GPT-4
 - Asked: A way to simulate data from our dataset that preserves relationships and correlation using statistical parameters.
 - Snippet: Can you generate simulated data from this dataset using key statistical parameters (min, max, preserved correlations, etc) and keeping the same sample number; give me the version of the code that conditions numeric simulation on each categorical group
 - Changed: Data upload portion of code so I am prompted to choose the desired file
 - Verified: Compared original and simulated data averages and other statistical paramters
## Processing Lee's Data
- Tool/model & version: ChatGPT GPT-4.0
- What I asked for: To pre-process Lee’s data, ChatGPT was given part of the R code from the open-source paper and was asked to create an Excel file with certain variables. 
- Snippet of prompt(s): I need to extract data for color change plasticity and initial color and put them in an Excel file. I have this R code: [code inserted here]. Can you please write some R code to extract these variables and combine them with the ecological variables?
- What I changed before committing: I added this code block to the end of Script_Color_Plasticity_Data.R.
- How I verified correctness (tests, sample data): This output was verified by checking the Excel file after it was created and comparing it to the original data matrices created in R.
## Correlation Scatter plots
- Tool/model & version: ChatGPT GPT-4.0
- What I asked for: Nearly six months ago I used ChatGPT to imrpove the aesthetics of the plots I was making in GGplots when making scatter plots about correlation. I used these codes from a past project, and just edited them to apply to my new datasets/variables (Christian's and Lee's).
- Snippet of prompt(s): I do not have the prompts anymore, it was way back when I was a master's student.
- What I changed before committing: The variables and data sets the code was utilizing for the graphs.
- How I verified correctness (tests, sample data): Visually assessed the data to ensure it had the same layout from my rudimentary scatter plot. Also, ensured the test statistics displayed were the same.  
## Confusion Matrix
- Tool: Chat GPT; GPT-4
- Asked: To help fix my code for the confusion matrix
- Snippet: what does this error mean on my confusion matrix code: NameError Traceback (most recent call last)
- Changed: changed Data.Population in code to y_test.unique
- Verified: Ran code to ensure completion and that the proper display names appeared on the matrix. 
## Use Trained Pipeline
- Tool: Chat GPT; GPT-4
- Asked: How to use my trained pipeline with new data
- Snippet: How do I use a trained pipeline classifier on python to test a different set of data
- Changed: Steps in previous pipeline (ex. log transform, data splitting, etc.) (found out previous code was incorrect)
- Verified: Ran code to completion
## Log Transform Fix
- Tool: Chat GPT; GPT-4
- Asked: How to fix code so only one variable is log transformed
- Snippet: How would i fix these codes to log transform only one variable
- Changed: Column name that needs to be log transformed. 
- Verified: Confirmed code section looked correct and properly ran. 
## Color Bar Fix
- Tool: Chat GPT; GPT-4
- Asked: How to make color bar simpler
- Snippet: How do i fix this section of code so that the color bar/legend only shows the colors associated with the population
- Changed: Color bar code snippet
- Verified: Ran code to see if color legend is simpler
## Random forest feature importance
- Tool/model & version: Chat GPT; GPT-4
- What I asked for: Crafting a code to obtain random forest feature importance. This was so we could quantify the ability to differentiate based off of the variables. 
- Snippet of prompt(s): I used the same code I had from the module 10 homework, which I originally crafted with AI. I did not save this AI interaction, but I asked it to help me add a code in that took my existing Random Forest testing and went further to capture the feature importance. 
- What I changed before committing: The dataset the code pertained to was changed in the code.
- How I verified correctness (tests, sample data): On the homework, it was deemed the correct answer. So, I had faith it would still run properly. I also compared the numerical output to other visual results to see if they were logical. 
