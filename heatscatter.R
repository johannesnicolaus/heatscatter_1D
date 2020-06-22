
# functions needed to make 1D heat scatter plot ---------------------------
library(tidyverse)
library(reshape2)


# melt and calculate density 
calc_density_melt <- function(df, variable = "variable", value = "value"){
  df %>% melt() %>% group_by(!! sym(variable))  %>% mutate(dens = approxfun(density(!! sym(value)))(!! sym(value))) %>% ungroup() %>% print()
}

# calculate density on previously melt() object
calc_density <- function(df, variable = "variable", value = "value"){
  df %>% group_by(!! sym(variable))  %>% mutate(dens = approxfun(density(!! sym(value)))(!! sym(value))) %>% ungroup() %>% print()
}


# plot heat scatter
heat_scatter <- function(df, variable = "variable", value = "value", dens = "dens", scatter_width = 0.1){
  
  plot_object <- ggplot(df) + geom_jitter(aes(x = !! sym(variable),y = !! sym(value), color = !! sym(dens)), width = scatter_width) + scale_color_viridis_c()
  
  print(plot_object)
}






# example -----------------------------------------------------------------
df <- tibble("1" = runif(100), "2" = runif(100), "3" = runif(100))

heat_scatter(calc_density_melt(df))


