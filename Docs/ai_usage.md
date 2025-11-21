# AI Use Log
- Tool/model & version:
- What I asked for:
- Snippet of prompt(s):
- What I changed before committing:
- How I verified correctness (tests, sample data):

 - Tool: ChatGPT; GPT-4
 - Asked: A way to simulate data from our dataset that preserves relationships and correlation using statistical parameters.
 - Snippet: Can you generate simulated data from this dataset using key statistical parameters (min, max, preserved correlations, etc) and keeping the same sample number; give me the version of the code that conditions numeric simulation on each categorical group
 - Changed: Data upload portion of code so I am prompted to choose the desired file
 - Verified: Compared original and simulated data averages and other statistical paramters

- Tool/model & version: ChatGPT GPT-4.0
- What I asked for: To pre-process Lee’s data, ChatGPT was given part of the R code from the open-source paper and was asked to create an Excel file with certain variables. 
- Snippet of prompt(s): I need to extract data for color change plasticity and initial color and put them in an Excel file. I have this R code: [code inserted here]. Can you please write some R code to extract these variables and combine them with the ecological variables?
- What I changed before committing: I added this code block to the end of Script_Color_Plasticity_Data.R.
- How I verified correctness (tests, sample data): This output was verified by checking the Excel file after it was created and comparing it to the original data matrices created in R. 
