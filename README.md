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
Three common categories of image enhancements involve adjustments to contrast, sharpness, and noise in images ([Liu, 2022](https://www.sciencedirect.com/science/article/abs/pii/S1051200422001646#se0070); [Pei, 2023](https://www.sciencedirect.com/science/article/pii/S0264127523005014#b0140)). Within these three categories, enhancements were chosen that can be implemented using a Jupyter notebook, require limited computer processing, have available and easy to use code, work on our image collection, and have been mentioned as successful in the literature. The nine methods I chose were within the many approaches to image enhancements, as reviewed in [Gonzales and Wood (2019)](https://dl.icdst.org/pdfs/files4/01c56e081202b62bd7d3b4f8545775fb.pdf), [Liu (2022)](https://www.sciencedirect.com/science/article/abs/pii/S1051200422001646#se0070), and [Qi (2022)](https://link.springer.com/article/10.1007/s11831-021-09587-6). 

The [Image Enhancement Jupyter notebook](https://github.com/larissaissabron/JCURA_PyLC_2024/blob/main/JCURA2024_ImageEnhancementCode.ipynb) that can be used with the [test image set](https://zenodo.org/records/10827942?token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6ImQxZmJjNThlLTBhYmMtNDFlNC1hNzEyLTRmN2Q5ZDBmYjk0NCIsImRhdGEiOnt9LCJyYW5kb20iOiJiMzBkZDJiOGRiOTE1YjQ3NmQ1YzlmYjE4ZWI0YjhmOSJ9.pIpAVBCVxQtuO7YLUgFzyJqd7uvoYQ80QfVYuiDsXcXl5Kbmhhr6bybNTYg-6S0n2dsBEUZjGR-lR6-2Vr1ZOA). The resulting images that I worked with are available from MLP in the "PyLCShared2023" folder. 

### 3. Testing Enhanced Images with PyLC
The testing set (unenhanced baseline) and the nine enhanced versions of the testing set were each individually ran through PyLC using grayscale model 2-3 using Terminal on a Mac. After running an image set through PyLC, there is a landcover mask for each image and accuracy metrics that compare PyLC's masks to the manually-annotated reference mask. Each image set was run through twice to get accuracy readouts that were individual to each image (no flag) and averaged over each image set (--aggregate metrics flag). 

If you would like to try using PyLC, there are instructions on the [PyLC GitHub](https://github.com/scrose/pylc) for running testing, with some further clarification in [this guide](https://github.com/larissaissabron/JCURA_PyLC_2024/blob/main/Guide_PyLC%20Testing%20and%20Training.pdf) for running PyLC on the Compute Canada server or on a personal computer. 

### 4. Comparing PyLC Accuracy Between Image Sets
PyLC accuracy metrics were compared at two nested levels with each image - individual land cover categories and averaged over an image. The reported PyLC accuracy metrics for individual images is an un-averaged F1 score for each land cover category, as well as the averaged accuracy metrics considering all land cover categories for the image. The averaged accuracy metrics are Matthew's Correlation Coefficient, Weighted Average F1 score, and an Inverse-Weighted Intersection Over Union. 

I chose to compare the median accuracy for land cover categories and the median averaged accuracy metrics using boxplots in R because my accuracy metrics did not easily fit into a standard statistical test. When I followed an undergrad stats flowchart (ex., [Stats and R Flowchart: What Statistical Test Should I Do?](https://statsandr.com/blog/what-statistical-test-should-i-do/)), I was lead to using the Wilcoxon Sign-Ranked Test, yet I wasn't able to satisfy all of the assumptions ([Wilcoxon Sign-Ranked Test](https://pythonfordatascienceorg.wordpress.com/wilcoxon-sign-ranked-test-python/)). This realization also lined up with re-learning that null hypothesis significance testing might not tell us much about data (Ex., [Johnson, 1980](https://www.jstor.org/stable/3802789)), so I opted to visualize the output instead. 

----- Under construction! -----

(Make all accessible above)
- Turned the PyLC output into something easier to work with
- Put together .csv files of everything
- R code for visualization

## Results
- PyLC responds to enhancements. How you compared images using Affinity Photo 2. What you saw overall. Example from the poster up above (maybe it can be a pdf of them together) + the affinity photo 2 file.
- Comparing median accuracy metrics. Graphs above?

## Discussion 
- Don't forget the references in text.

## Acknowledgements
- Include expanded ack. about the use of the images
