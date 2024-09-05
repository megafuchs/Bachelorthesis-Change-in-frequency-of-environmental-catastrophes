# Change in Frequency of Environmental Catastrophes – A Bayesian Analysis

# Overview

This repository contains two primary components:

**Bachelor Thesis (PDF):** My complete bachelor's thesis titled "Change in Frequency of Environmental Catastrophes – A Bayesian Analysis", submitted to the Vienna University of Economics and Business in 2023. It provides a detailed analysis of how the frequency of hydrological, climatological, and meteorological disasters has changed over time and how it will likely develop in the future using a Bayesian statistical model.
**Core Bayesian Model Code (R):** A key snippet of R code from my thesis demonstrating the core model that underpins the analysis. This model is used to predict the future occurrence of environmental catastrophes through a Bayesian hierarchical approach, with a Poisson distribution to model disaster occurrences.
Files

Change-in-frequency-of-environmental-catastrophes-a-Bayesian-analysis.pdf
The complete thesis, including a comprehensive review of the literature, methodology, results, and discussion of the exponential increase in natural disasters over time.

bayesian_model.R
The code file containing the essential R code for the Bayesian model used in the thesis. It includes data manipulation and a Bayesian Poisson regression model to estimate the growth of environmental disasters.
About the Thesis

The thesis investigates the exponential increase in the frequency of environmental disasters such as floods, droughts, and storms between 1950 and 2020. Using a Bayesian indexed-covariate-multilevel model, I project future disaster occurrences up to 2050. Key findings suggest a 30-fold increase in disaster frequencies for some categories within the next 20 years.

# About the Bayesian Model Code

This R script showcases the core of my Bayesian model. Here's a brief breakdown of its components:

Data Preparation: The dataset of environmental catastrophes is filtered to focus on the relevant period (post-1950) and disaster types (climatological, hydrological, meteorological).
Hierarchical Bayesian Model: The disaster counts are modeled using a Poisson distribution with a log-link function, allowing for the disaster frequency to increase exponentially over time. Random effects capture variations between disaster types.
Model Output: The model is run using the ulam function from the rethinking package, with outputs used to project disaster counts for the future.
The use of Bayesian methods enables us to handle uncertainty in a principled way, providing full posterior distributions for our predictions rather than just point estimates.

# Instructions

Thesis: Read the thesis for a detailed explanation of the methodology, results, and interpretation of the model.
Running the Code: To run the Bayesian model on your machine, ensure that you have the necessary libraries (rethinking, tidyverse, etc.) installed in your R environment. The code is structured to take a cleaned dataset and output model predictions.
Requirements

R version 4.0 or higher
The following R packages:
rethinking
tidyverse
zoo
dplyr
kableExtra
License

This repository is open for academic and non-commercial use. Please credit this work appropriately if you intend to use or build upon it.

