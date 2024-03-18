# JCURA Data Analysis -----------------------------------------------------

# All code developed  following R for Data Science 2e (https://r4ds.hadley.nz/) with the support of Stack Overflow and ChatGPT for debugging


# 0. Load libraries ------------------------------------------------------------

library(tidyverse)
library(readr)
library(RColorBrewer)
library(stringr)

# 1. Importing data into R ---------------------------------------------------

# A. Read in the .csv file for the accuracy metrics averaged over all LCCs for all images and the F1 scores for each LCC per image. The accuracy metrics are WMF1 (weighted mean F1 score), IWMIoU (inversely weighted mean intersection over union), and MCC (matthew's correlation coefficient). 

# Read in the .csv files as a tibble using readr so that you can work within the tidyverse. Each image in the test set is a row. 

# Accuracy values averaged over all LCC's per image.
avg_acc_tib <- read_csv("data/processed/image_mcc_wmf1_iwmiou.csv")

# F1 scores for each LCC per image (F1 scores not averaged, so there is no weighted mean (wm) in the name).
lccf1_tib <- read_csv("data/processed/img_en_lccf1.csv")


# 2. Visualizing the data using boxplots -------------------------------

# 2a. Pivot the columns to be in rows for both tibble
lccf1_tib_long <- lccf1_tib %>%
  pivot_longer(cols = c(test, cla, gam, con, den, bil, wav, uns, hig, wie), 
               names_to = "test", values_to = "f1")

avg_acc_tib_long <- avg_acc_tib %>% 
  pivot_longer(cols = c(test, cla, gam, con, den, bil, wav, uns, hig, wie), 
                names_to = "test", values_to = "accuracy_read")

# 2b. Boxplot for each accuracy metric calculated for each image enhancement test

# Averaged accuracy metrics -----------------------------------------------


# Reorder the levels of the 'test' variable manually
avg_acc_tib_long$test <- factor(avg_acc_tib_long$test, 
                                levels = c("test", "cla", "gam", "con", 
                                           "den", "bil", "wav", "uns", 
                                           "hig", "wie"))

# Create a new grouping variable based on your categories
avg_acc_tib_long <- avg_acc_tib_long %>%
  mutate(group = case_when(
    test %in% c("test") ~ "2023 Test Set",
    test %in% c("cla", "gam", "con") ~ "Increase Contrast",
    test %in% c("den", "bil", "wav") ~ "Reduce Noise",
    test %in% c("uns", "hig", "wie") ~ "Sharpen"
  ))

# Labels for facets
avg_acc_facet_labels <- c("Inverse Weighted Mean IoU", "Matthew's Correlation Coefficient", "Weighted Mean F1 Score")

names(avg_acc_facet_labels) <- c("iwm_iou", "mcc", "wm_f1")

# Make the image enhancement test labels more informative
# Create a new grouping variable based on your categories
avg_acc_tib_long <- avg_acc_tib_long %>%
  mutate(enhance_name = case_when(
    test %in% c("test") ~ "No Enhancement",
    test %in% c("cla") ~ "CLAHE",
    test %in% c("gam") ~ "Gamma Correction",
    test %in% c("con") ~ "Contrast Stretch",
    test %in% c("den") ~ "Denoise",
    test %in% c("bil") ~ "Bilateral Filter",
    test %in% c("wav") ~ "Wavelet Denoise",
    test %in% c("uns") ~ "Unsharp Mask",
    test %in% c("hig") ~ "High Pass Filter",
    test %in% c("wie") ~ "Wiener Filter"
  ))

# Convert enhance_name to a factor with desired order so it appears the way you want it in the axis
avg_acc_tib_long$enhance_name <- factor(avg_acc_tib_long$enhance_name, levels = unique(avg_acc_tib_long$enhance_name))

# Make the facet wrap labels more informative
# Create a new grouping variable based on your categories
avg_acc_tib_long <- avg_acc_tib_long %>%
  mutate(accuracy_long = case_when(
    accuracy %in% c("mcc") ~ "Matthew's Correlation Coefficient",
    accuracy %in% c("iwm_iou") ~ "Inverse Weighted Mean Intersection Over Union",
    accuracy %in% c("wm_f1") ~ "Weighted Mean F1 Score"
  ))

# Create bar plot that is coloured based on image enhancement type (colours chosen for color-blind-friendly palette [http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette])
ggplot(avg_acc_tib_long, aes(x = enhance_name, y = accuracy_read, fill = group)) +
  geom_boxplot() +
  facet_wrap(~ accuracy_long, labeller = label_wrap_gen(width = 15)) +
  scale_fill_manual(values = c("2023 Test Set" = "#E69F00", 
                               "Increase Contrast" = "#56B4E9", 
                               "Reduce Noise" = "#009E73", 
                               "Sharpen" = "#F0E442")) +
  labs(fill = "Test Category") +
  ggtitle("Per-Image Average Accuracy Metrics") +
  xlab("Image Enhancement") + ylab("Accuracy Score") +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) 

# LCC f1 scores -----------------------------------------------------------

# Reorder the levels of the 'test' variable manually
lccf1_tib_long$test <- factor(lccf1_tib_long$test, 
                                levels = c("test", "cla", "gam", "con", 
                                           "den", "bil", "wav", "uns", 
                                           "hig", "wie"))

# Create a new grouping variable based on your categories
lccf1_tib_long <- lccf1_tib_long %>%
  mutate(group = case_when(
    test %in% c("test") ~ "2023 Test Set",
    test %in% c("cla", "gam", "con") ~ "Increase Contrast",
    test %in% c("den", "bil", "wav") ~ "Reduce Noise",
    test %in% c("uns", "hig", "wie") ~ "Sharpen"
  ))

# Labels for facets
lccf1_facet_labels <- c("Broadleaf-Mixed Wood", "Conifer", "Herbaceous Shrub", "Not Classified", "Regenerating Area", "Sand-Gravel-Rock", "Snow-Ice", "Wetland", "Water")

names(lccf1_facet_labels) <- c("bmw", "c", "hs", "nc", "ra", "sgr", "si", "wl", "wt")

# Make the image enhancement test labels more informative
# Create a new grouping variable based on your categories
lccf1_tib_long <- lccf1_tib_long %>%
  mutate(enhance_name = case_when(
    test %in% c("test") ~ "No Enhancement",
    test %in% c("cla") ~ "CLAHE",
    test %in% c("gam") ~ "Gamma Correction",
    test %in% c("con") ~ "Contrast Stretch",
    test %in% c("den") ~ "Denoise",
    test %in% c("bil") ~ "Bilateral Filter",
    test %in% c("wav") ~ "Wavelet Denoise",
    test %in% c("uns") ~ "Unsharp Mask",
    test %in% c("hig") ~ "High Pass Filter",
    test %in% c("wie") ~ "Wiener Filter"
  ))

# Convert enhance_name to a factor with desired order so it appears the way you want it in the axis
lccf1_tib_long$enhance_name <- factor(lccf1_tib_long$enhance_name, levels = unique(lccf1_tib_long$enhance_name))

# Make the image enhancement test labels more informative
# Create a new grouping variable based on your categories
lccf1_tib_long <- lccf1_tib_long %>%
  mutate(lcc_long = case_when(
    lcc %in% c("nc") ~ "Not Categorized",
    lcc %in% c("bmw") ~ "Broadleaf-Mixed Wood Forest",
    lcc %in% c("c") ~ "Conifer Forest",
    lcc %in% c("hs") ~ "Herbaceous-Shrub",
    lcc %in% c("ra") ~ "Regenerating Area",
    lcc %in% c("sgr") ~ "Sand-Gravel-Rock",
    lcc %in% c("si") ~ "Snow-Ice",
    lcc %in% c("wl") ~ "Wetland",
    lcc %in% c("wt") ~ "Water"
  ))

# Create bar plot that is coloured based on image enhancement type
lccf1_tib_long %>% 
  subset(pixels > 10000) %>% # Filter out any lcc that had less than 10 000 pixels so that there aren't erroneous 1 (perfect) values in visual %>% 
  ggplot(aes(x = enhance_name, y = f1, fill = group)) +
  geom_boxplot() +
  facet_wrap(~ lcc_long) +
  scale_fill_manual(values = c("2023 Test Set" = "#E69F00", 
                               "Increase Contrast" = "#56B4E9", 
                               "Reduce Noise" = "#009E73", 
                               "Sharpen" = "#F0E442")) +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) +
  labs(fill = "Test Category") +
  ggtitle("Per-Image Land Cover Category F1 Scores") +
  xlab("Image Enhancement") + ylab("F1 Score") 


# Updating boxplots for JCURA poster --------------------------------------

# Averaged accuracy metrics

# Create bar plot that is coloured based on image enhancement type (colours chosen for color-blind-friendly palette [http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette])
trans_boxplot_avg <- ggplot(avg_acc_tib_long, aes(x = enhance_name, y = accuracy_read, fill = group)) +
  geom_boxplot() +
  facet_wrap(~ accuracy_long, labeller = label_wrap_gen(width = 25)) +
  scale_fill_manual(values = c("2023 Test Set" = "#f9f4f3", 
                               "Increase Contrast" = "#d6d5d5", 
                               "Reduce Noise" = "#b2aead", 
                               "Sharpen" = "#7c7c7c")) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
        legend.position = "top",
        legend.justification = c(1,1),
        plot.margin = unit(c(1, 1, 1, 1), "lines"),  # Adjust margins
        plot.background = element_rect(fill = "transparent", color = NA)) +  # Set background to transparent
  labs(fill = "",
       title = "Per-Image Averaged Accuracy Metrics",
       x = "Image Enhancement", 
       y = "Accuracy Score")

print(trans_boxplot_avg)

ggsave("trans_boxplot_avg.png", plot = trans_boxplot_avg, bg = "transparent", width = 12, height = 8.453, units = "in", dpi = 300)

# F1 score for each lcc

# Create bar plot that is coloured based on image enhancement type
trans_boxplot_lcc <- lccf1_tib_long %>% 
  subset(pixels > 10000) %>% 
  ggplot(aes(x = enhance_name, y = f1, fill = group)) +
  geom_boxplot() +
  facet_wrap(~ lcc_long) +
  scale_fill_manual(values = c("2023 Test Set" = "#f9f4f3", 
                               "Increase Contrast" = "#d6d5d5", 
                               "Reduce Noise" = "#b2aead", 
                               "Sharpen" = "#7c7c7c")) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
        legend.position = "top",
        legend.justification = c(1,1),
        plot.margin = unit(c(1, 1, 1, 1), "lines"),  # Adjust margins
        plot.background = element_rect(fill = "transparent"),
        panel.grid = element_line(linewidth = 0.5, colour = "#dedcdc", linetype = "dotted")) +  # Set background to transparent
  labs(fill = "",
       title = "Per-Image Land Cover Category F1 Scores",
       x = "Image Enhancement", 
       y = "F1 Score")

# Print the plot
print(trans_boxplot_lcc)

ggsave("trans_boxplot_lcc2.pdf", plot = trans_boxplot_lcc, bg = "transparent", width = 12, height = 8.453, units = "in", dpi = 300)
