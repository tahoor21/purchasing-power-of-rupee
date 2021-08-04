# purchasing-power-of-rupee
In this repository I explain how to plot the famous graph of the loss of purchasing power of Indian Rupee or any other currency in R language.

![alt text](https://github.com/tahoor21/purchasing-power-of-rupee/blob/main/plot.png?raw=true)

# code and explanations

First, the required libraries are: readxl, jpeg, grid and ggplot2.
```
library(readxl)
library(jpeg)
library(grid)
library(ggplot2)
```

Do not forget to specify the path to the files.
```
setwd("### YOUR FOLDER'S PATH ###")
```

Then, load and format the data according to your needs. Here, I will take the beginning of my data series from January 1, 1970 and I calculate the loss of purchasing power from the beginning.
```
df <- read_xls("data.xls")
colnames(df) <- c("Date", "CPI")

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

df$PP <- df$CPI[1] / df$CPI
```

To load your banknote image.
```
banknote <- readJPEG("rupee.jpeg")
banknote <- rasterGrob(banknote, width = unit(1, "npc"), height = unit(1, "npc"), interpolate = TRUE) 
```

Last, use ggplot2 to draw the chart.
```
graph <- ggplot(df, aes(x = Date, y = PP)) +
  
  annotation_custom(banknote, xmin = -Inf, xmax = Inf, ymin = 0, ymax = Inf) +
  
  geom_ribbon(aes(ymin = PP, ymax = Inf), alpha = 0.75, fill = "white") +
  
  geom_line(size=1, colour="#000000") +
  
  scale_x_date(date_breaks="2 year", date_labels = "%Y", expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0), labels=scales::percent, limits = c(0,1), breaks=seq(0, 1, 0.1)) +
  
  labs(
    title = "Purchasing Power of Rupee",
    subtitle = "(January 1, 1970 = 100%)",
    x="",
    y="",
    caption="Data: CPI (Combined), Source: Organization for Economic Co-operation and Development") +
  
  theme_minimal() +
  theme(plot.title = element_text(face="bold", hjust=0.5, size=rel(1.5)),
        plot.subtitle = element_text(face="italic", hjust=0.5),
        axis.text.x = element_text(vjust = -3))

graph
```

# source of the data
- Consumer Price Index: All Items for India, Organization for Economic Co-operation and Development. Link: https://fred.stlouisfed.org/series/INDCPIALLMINMEI#
