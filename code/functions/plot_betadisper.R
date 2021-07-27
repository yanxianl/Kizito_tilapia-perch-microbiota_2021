###############################################################################
# plot_betadisper

# Copyright (c) 2021 Yanxian Li

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
###############################################################################

# Author: Yanxian Li
# Email: yanxianl@nmbu.no

# load libararies
for (lib in c("tidyverse")) {
  suppressPackageStartupMessages(require(lib, character.only = TRUE))
}

# define function
plot_betadisper <- function(
  betadisper,
  xlab = NULL, 
  ylab = "Distance to centroid", 
  title = NULL,
  col = "lightblue") {
  
  data.frame(
    dist = betadisper$distances, 
    group = betadisper$group
    ) %>%
    ggplot(aes(x = group,y = dist)) +
    geom_boxplot(fill = col, width = 0.5) +
    geom_point() + 
    labs(x = xlab, y = ylab, title = title) +
    theme_minimal() 
  }
