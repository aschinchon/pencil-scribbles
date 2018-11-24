# Pencil Scribbles

In this experiment I use an algorithm to solve the Travelling Salesman Problem (TSP) to make a drawing from a picture. It is inspired by [this previous one](https://github.com/aschinchon/travelling-salesman-portrait). Briefly, these are the steps:
+ Load the image
+ Transform it to gray scale
+ Obtain a sample of pixels
+ Draw the path obtained solving the TSP for sampled points

Overlapping 250 paths and giving transparency to lines (`alpha`) the resulting drawing has a *pencil effect*. For example, if you load this image:

<img src="https://fronkonstin.com/wp-content/uploads/2018/04/frankenstein.jpg" style="max-height: 100px; max-width: 100px;" />

The output is this one:

<img src="https://fronkonstin.com/wp-content/uploads/2018/04/franky_scribbles2.png" style="max-height: 100px; max-width: 100px;" />

## Getting Started

### Prerequisites

The code is R. You will need to install the following packages (if you don't have them already):

```
install.packages("imager")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("scales")
install.packages("TSP")
```

## More info

A complete explanation of the experiment can be found [at fronkonstin](https://fronkonstin.com/2018/04/17/pencil-scribbles/)

## Authors

* **Antonio Sánchez Chinchón** - [@aschinchon](https://twitter.com/aschinchon)

