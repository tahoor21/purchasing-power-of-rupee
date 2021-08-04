library(readxl)
library(jpeg)
library(grid)
library(ggplot2)

df <- read_xls("data2.xls")
colnames(df) <- c("Date", "CPI")

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

df$PP <- df$CPI[1] / df$CPI
banknote <- readJPEG("rupee.jpeg")
banknote <- rasterGrob(banknote, width = unit(1, "npc"), height = unit(1, "npc"), interpolate = TRUE) 

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
