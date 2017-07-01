#######################
##### Word Clouds #####
#######################

library(tm)
library(SnowballC)
library(wordcloud)
library(dplyr)
library(RColorBrewer)

############################# Richard Spencer ##################################

RSdata_raw <- read.csv("./Richard_Spencer_Follower_Data.csv", na.strings = "NA")

RS_wordcloudData <- tbl_df(RSdata_raw)

# get data ready for word cloud - Remove NA's select only description column
RS_wordcloudData <- RS_wordcloudData %>% select(description) %>% 
    mutate(as.character(description)) %>% filter(!is.na(description))

# Create initial corpus object to create word document
RSCorpus <- Corpus(VectorSource(RS_wordcloudData$description))

#remove punctuation 
RSCorpus <- tm_map(RSCorpus, removePunctuation)

# Remove stopwords 
RSCorpus <- tm_map(RSCorpus, removeWords, stopwords('english'))
RSCorpus <- tm_map(RSCorpus, removeWords, c("the", "this"))

# Stemming - ommited due to strange results
# bhCorpus <- tm_map(bhCorpus, stemDocument)


### All different shades of Red
set.seed(808)
wordcloud(RSCorpus, max.words = 100, random.order = F, colors=rev(colorRampPalette(brewer.pal(9,"Reds"))(32)[seq(8,32,6)]))


# Different colors
set.seed(808)
wordcloud(RSCorpus, max.words = 100, random.order = F, colors=brewer.pal(8, "Dark2"), scale=c(10,1.25))

set.seed(808)
wordcloud(RSCorpus, max.words = 100, random.order = F, colors=brewer.pal(11, "RdYlGn"))


########################### David Duke #########################################

DDdata_raw <- read.csv("./David_Duke_Follower_Data.csv", na.strings = "NA")

DD_wordcloudData <- tbl_df(DDdata_raw)

# get data ready for word cloud - Remove NA's select only description column
DD_wordcloudData <- DD_wordcloudData %>% select(description) %>% 
    mutate(as.character(description)) %>% filter(!is.na(description))

# Create initial corpus object to create word document
DDCorpus <- Corpus(VectorSource(DD_wordcloudData$description))

#remove punctuation 
DDCorpus <- tm_map(DDCorpus, removePunctuation)

# Remove stopwords 
DDCorpus <- tm_map(DDCorpus, removeWords, stopwords('english'))
DDCorpus <- tm_map(DDCorpus, removeWords, c("the", "this"))

# Stemming - ommited due to strange results
# bhCorpus <- tm_map(bhCorpus, stemDocument)


### All different shades of blue
set.seed(808)
wordcloud(DDCorpus, max.words = 100, random.order = F, colors=rev(colorRampPalette(brewer.pal(9,"Oranges"))(32)[seq(8,32,6)]))


# Different colors
set.seed(808)
wordcloud(DDCorpus, max.words = 100, random.order = F, colors=brewer.pal(8, "Dark2"), scale=c(10,1.25))

set.seed(808)
wordcloud(DDCorpus, max.words = 100, random.order = F, colors=brewer.pal(11, "RdYlGn"))



