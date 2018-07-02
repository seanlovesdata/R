install.packages("tidyquant")
library(tidyquant)

from <- today() - years(1)
AAPL <- tq_get("AAPL", get = "stock.prices", from = from)
AAPL

tq_mutate_fun_options() %>% 
  str()


## pipe stock prices TO ADD SMA for 15 and 50 days
AAPL %>%
  tq_mutate(x_fun = Cl, mutate_fun = SMA, n = 15) %>%
  rename(SMA.15 = SMA) %>%
  tq_mutate(x_fun = Cl, mutate_fun = SMA, n = 50) %>%
  rename(SMA.50 = SMA)

## tidy data 
AAPL %>%
  select(date, close, SMA.15, SMA.50) %>%
  gather(key = type, value = price, close:SMA.50)
AAPL %>%
  tq_mutate_xy(.x = close, mutate_fun = SMA, n = 15) %>%
  rename(SMA.15 = SMA) %>%
  tq_mutate_xy(.x = close, mutate_fun = SMA, n = 50) %>%
  rename(SMA.50 = SMA)

my_palette <- c("black", "blue", "red")
AAPL %>%
  select(date, close, SMA.15, SMA.50) %>%
  gather(key = type, value = price, close:SMA.50) %>%
  ggplot(aes(x = date, y = price, col = type)) +
  geom_line() +
  scale_colour_manual(values = my_palette) + 
  theme(legend.position="bottom") +
  ggtitle("Simple Moving Averages are a Breeze with tidyquant") +
  xlab("") + 
  ylab("Stock Price")
