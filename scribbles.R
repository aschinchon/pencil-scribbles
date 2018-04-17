library(imager)
library(dplyr)
library(ggplot2)
library(scales)
library(TSP)

# Download the image
urlfile="http://ereaderbackgrounds.com/movies/bw/Frankenstein.jpg"
file="frankenstein.jpg"
if (!file.exists(file)) download.file(urlfile, destfile = file, mode = 'wb')

# Load, convert to grayscale, filter image (to convert it to bw) and sample
load.image(file) %>% 
  grayscale() %>%  
  as.matrix -> X

# Convert the matrix to data frame 
dimnames(X) = list(row = 1:nrow(X), col = 1:ncol(X))
X <- reshape2::melt(X)
colnames(X)=c("x","y","value")  

# Start ggplot
plot=ggplot()  

# This loop adds layers to the plot
for (i in 1:250)
{
  # Weighted sample of pixels
  X %>% 
    sample_n(400, weight=1-value) %>% 
    select(x,y) -> data
  
  # Compute distances and solve TSP
  as.TSP(dist(data)) %>% 
    solve_TSP(method = "arbitrary_insertion") %>% 
    as.integer() -> solution
  
  # Create a dataframe with the output of TSP
  data.frame(id=solution) %>% 
    mutate(order=row_number()) -> order
  
  # Rearrange the original points according the TSP output
  data %>% 
    mutate(id=row_number()) %>% 
    inner_join(order, by="id") %>% arrange(order) %>% 
    select(x,y) -> data_to_plot
  
  # Add a new layer to prevous plot
  plot + geom_path(aes(x,y), data=data_to_plot, alpha=runif(1, min=0, max=0.1))->plot  
}  

# The final plot (at last)
plot +
  scale_y_continuous(trans=reverse_trans())+
  coord_fixed()+
  theme_void()

# Do you like the result? Save it! (Change the filename if you want)
ggsave("franky_scribbles.png", dpi=600, width = 4, height = 5)
