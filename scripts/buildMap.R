# BuildMap file: function that returns a plotly map. Modified from the one provided in class
library(plotly)
library(stringr)

# BuildMap function: Takes a data frame data, a user-decided input of map.var, and returns a plotly map

BuildMap <- function(data, map.var) {
  # light grey boundaries
  l <- list(color = toRGB("grey"), width = 0.5)
  
  # specify map projection/options
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = 'Mercator')
  )
  
  # Make equation for map color / text
  var.equation <- paste0('~', map.var)
  
  # Plot
  p <- plot_geo(data) %>%
    add_trace(
      z = eval(parse(text = var.equation)), text = ~Country, locations = ~CODE,
      color = eval(parse(text = var.equation)), colors = 'Purples'
    ) %>%
    colorbar(title = "Number of Cases (M = millions, k = thousands)") %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  return(p)
}