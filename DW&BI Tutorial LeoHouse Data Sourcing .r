install.packages("rvest")
install.packages(c("devtools", "rjson", "bit64", "httr"))
install.packages("twitteR")

library(twitteR)
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
lego_movie

# install selector gadget for chrome, type vignette("selectorgadget), this is to help you find what CSS selector matches the data you want
# in this case, to get the score we use "strong span"

lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

# same thing here except with the actors in the movie

lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()


lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()

## read URL

the_revenant <- read_html("http://www.imdb.com/title/tt1663202/?ref_=fn_al_tt_1")
wolf_of_wall_street <- read_html("http://www.imdb.com/title/tt0993846/?ref_=nv_sr_1")
django_unchained <- read_html("http://www.imdb.com/title/tt1853728/?ref_=nv_sr_1")
inception <- read_html("http://www.imdb.com/title/tt1375666/?ref_=nv_sr_1")
blood_diamond <- read_html("http://www.imdb.com/title/tt0450259/?ref_=nv_sr_1")

## ratings

the_revenant_rating <- 
  the_revenant %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

wolf_rating <- 
  wolf_of_wall_street %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

django_rating <- 
  django_unchained %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

inception_rating <- 
  inception %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

blood_diamond_rating <- 
  blood_diamond %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()


## financial information

the_revenant_financial <- 
  the_revenant %>% 
  html_nodes("#titleDetails ,.txt-block") %>%
  html_text() 

wolf_financial <- 
  wolf_of_wall_street %>% 
  html_nodes("#titleDetails ,.txt-block") %>%
  html_text() 

django_financial <- 
  django_unchained %>% 
  html_nodes("#titleDetails ,.txt-block") %>%
  html_text() 

inception_financial <- 
  inception %>% 
  html_nodes("#titleDetails ,.txt-block") %>%
  html_text() 

blood_diamond_financial <- 
  blood_diamond %>% 
  html_nodes("#titleDetails ,.txt-block") %>%
  html_text() 

the_revenant_financial[11:13]
wolf_financial[10:12]
django_financial[11:13]
inception_financial[11:13]
blood_diamond_financial[11:13]


########### quandl

Now, with a bit of research I was able to find out which companies produced/distributed the movies. Mosy of those companies are privately owned. As a result they are not traded on a stock exchange. However, for this use case I have decided to take the stock information of their parent companies who are listed on exchanges. The Quandl API is used to take the stock information. 

**The Revenant - 20th Century Fox (NASDAQ:FOXA)
**The Wolf of Wall Street - Paramount Pictures (owned by Viacom, NASDAQ:VIAB)
**Inception - Warner Bros (owned by Time Warner INC - NYSE:TWX)
**Blood Diamond - Warner Bros (owned by Time Warner Cable INC - NYSE:TWX)
**Django Unchained - Sony Pictures Releasing (Owned by Sony Corp - NYSE:SNE)

install.packages("Quandl")
library("Quandl")
Quandl.api_key("api_key")

stocks.foxa = Quandl("YAHOO/FOXA", collapse="daily", start_date="2005-01-01", type="ts")
stocks.viab = Quandl("YAHOO/VIAB", collapse="daily", start_date="2005-01-01", type="ts")
stocks.twx = Quandl("GOOG/NYSE_TWC", collapse="daily", start_date="2005-01-01", type="ts")
stocks.sne = Quandl("GOOG/NYSE_SNE", collapse="daily", start_date="2005-01-01", type="ts")



########### twitter

#here mz api keys would go, to run this example zou need to input you keys, and secrets
api_key <- "api_key"
api_secret <- "api_secret"
access_token <- "access_token"
access_token_secret <- "access_token_secret"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

InceptionTweets <- searchTwitter("Inception", n=500)
InceptionTweets
revtweets <- searchTwitter('The&Revenant', n = 250)

