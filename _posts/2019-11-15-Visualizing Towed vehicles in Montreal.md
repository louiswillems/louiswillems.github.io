---
layout: post
title: Predicting red wine from SAQ.com (Société des alcools du Québec)
---

<br>

**Objective**: The goal of this machine learning project is to develop a model that can predict red wine prices using SAQ data. We will also interpret the results to find the variables that are most predictive.

<br>

## Problem definition

In this post, we will build a regression model in order to predict red wine prices. We will get the data from SAQ website (Société des alcools du Québec). To do so, we will first extract the data from <a href="https://www.saq.com/content/SAQ/fr.html" target="_blank"> SAQ.com</a>. Once we get the data that we need, we will build our regressor model to predict red wine prices.

In this machine learning pipeline, we will :
- Get red wines data from SAQ.com
- Extract & uploading data
- Exploratory Data Analysis (EDA)
- Naive Baseline
- Feature Engineering & Model Selection
- Model Evaluation on test data
- Model Analysis (Interpretability)
- Conclusion

Note that the dataset has approximately 5000 rows. Our metric evaluation will be MAE. Feel free to see my repository on <a href="https://github.com/louiswillems/saq-price-predictions" target="_blank"> Github</a>.

*Important: For the purpose of our project, we will follow these steps in a linear fashion but machine learning pipeline is an iterative procedure.*
