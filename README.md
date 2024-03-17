## Overview
Hello there! Welcome to the GitHub page for the JCURA 2024 project "Mountains of Confusion: Evaluating Image Enhancement to Improve AI Landscape Classification" by Larissa Bron. 

## Background
The [Mountain Legacy Project](https://mountainlegacy.ca/) (MLP) works with the largest systematic collection of mountain photographs in the world ([browse the collection](https://explore.mountainlegacy.ca/)). More than 10,000 historic images have been repeated to quantify landscape change over time. 

Quantitative comparison of how the distribution of ecosystems across the landscape change between historic and modern images requires pixel-by-pixel mapping of ecosystems. This time-consuming task has considerably held up scaling up the research team's investigation of the Canadian Rockies. 

To address this bottleneck, the [Python Landscape Classification](https://github.com/scrose/pylc) (PyLC) tool was developed to automate ecosystem classification using Artificial Intelligence (AI) semantic segmentation. PuLC is a proof-of-concept tool that has a high accuracy when working with images similar to the training data set and the MLP team is working to improve PyLC to better generalize to the larger image collection through experimentation, such as increasing the number of training images and updating the model architecture.  

## JCURA Project Research Approach
In Summer 2023, Larissa Bron worked alongside Kristyn Lang on improving PyLC as undergraduate research assistants. While Kristyn approached improving PyLC through updating the training process, Larissa experimented with image enhancement to improve PyLC accuracy with the hypothesis "Improving the appearance of ecosystems in images by applying image enhancements will clarify ecosystem characteristics, improving PyLC accuracy for classification." This hypothesis follows MLP researcher experience since 2013 in which manual ecosystem mapping was made easier by changing image conditions to better visualize the differences between ecosystem types. 

## Methods

### 1. Updating the PyLC Test Image Set
PyLC was trained using 95 images from two researcher's work, [Fortin (2018)](https://dspace.library.uvic.ca/items/0a911eb0-53bf-4a82-a75a-8b6949c28edd) and [Jean et al. (2015)](https://ieeexplore.ieee.org/document/7045940), and tested with 19 images that were a combination of 11 images from Fortin and Jean withheld from training and 8 images from the Landscapes in Motion project [(Higgs et al., (2020))](https://friresearch.ca/publications/advances-visual-applications-visualizing-quantifying-landscape-change-sw-alberta-using). 
