## Overview
Hello there! Welcome to the GitHub page for the JCURA 2024 project "Mountains of Confusion: Evaluating Image Enhancement to Improve AI Landscape Classification" by Larissa Bron. I wanted to expand the condensed information in the academic poster on GitHub in lieu of another published format to communicate my experimental methods and provide a unified repository of the code, data, and image sets that were used. 

## Background
The [Mountain Legacy Project](https://mountainlegacy.ca/) (MLP) works with the largest systematic collection of mountain photographs in the world ([browse the collection](https://explore.mountainlegacy.ca/)). More than 10,000 historic images have been repeated to quantify landscape change over time. 

Quantitative comparison of how the distribution of ecosystems across the landscape change between historic and modern images requires pixel-by-pixel mapping of ecosystems. This time-consuming task has considerably held up scaling up the research team's investigation of the Canadian Rockies. 

To address this bottleneck, the [Python Landscape Classification](https://github.com/scrose/pylc) (PyLC) tool was developed to automate ecosystem classification using Artificial Intelligence (AI) semantic segmentation. PuLC is a proof-of-concept tool that has a high accuracy when working with images similar to the training data set and the MLP team is working to improve PyLC to better generalize to the larger image collection through experimentation, such as increasing the number of training images and updating the model architecture.  

In Summer 2023, I worked alongside Kristyn Lang on improving PyLC as undergraduate research assistants. While Kristyn approached improving PyLC through updating the training process, I experimented with image enhancements to improve PyLC accuracy with the hypothesis "Improving the appearance of ecosystems in images by applying image enhancements will clarify ecosystem characteristics, improving PyLC accuracy for classification." This hypothesis was created following MLP researcher experience since 2013 in which manual ecosystem mapping was made easier by changing image conditions to better visualize the differences between ecosystem types. 

## Methods

### 1. Updating the PyLC Test Image Set
PyLC was trained using 95 images from two researcher's work, [Fortin (2018)](https://dspace.library.uvic.ca/items/0a911eb0-53bf-4a82-a75a-8b6949c28edd) and [Jean et al. (2015)](https://ieeexplore.ieee.org/document/7045940), and tested with 19 images that were a combination of 11 images from Fortin and Jean withheld from training and 8 images from the Landscapes in Motion project [(Higgs et al., (2020))](https://friresearch.ca/publications/advances-visual-applications-visualizing-quantifying-landscape-change-sw-alberta-using). 

The testing image set was updated to: 1) Incorporate images from more geographic areas to improve understanding of the generizability of PyLC to the MLP collection, and 2) Remove images with reference land cover masks with large errors to assess whether this was impacting PyLC accuracy. The updated "2023 Test Image Set" containing images and land cover masks are [hosted on Zenodo](https://zenodo.org/records/10827942?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6ImQxZmJjNThlLTBhYmMtNDFlNC1hNzEyLTRmN2Q5ZDBmYjk0NCIsImRhdGEiOnt9LCJyYW5kb20iOiJiMzBkZDJiOGRiOTE1YjQ3NmQ1YzlmYjE4ZWI0YjhmOSJ9.pIpAVBCVxQtuO7YLUgFzyJqd7uvoYQ80QfVYuiDsXcXl5Kbmhhr6bybNTYg-6S0n2dsBEUZjGR-lR6-2Vr1ZOA). 

### 2. Applying Image Enhancement to the Test Image Set
Three common categories of image enhancements involve adjustments to contrast, sharpness, and noise in images ([Liu, 2022](https://www.sciencedirect.com/science/article/abs/pii/S1051200422001646#se0070); [Pei, 2023](https://www.sciencedirect.com/science/article/pii/S0264127523005014#b0140)). 

The steps involved in image enhancements were:

2a. Sourcing image enhancements that could be coded simply in a Jupyter notebook using Python code. Working with code allowed for more control of how enhancements were applied and made it so that the same enhancement could be applied to each image simultaneously (which is difficult in programs like Photoshop). 

2b. 


