
#PRODIGY InfoTech Task 4
twitter<-read.csv("C:/Users/priya/Downloads/Twitter data.csv")#load data
install.packages("tidyverse")
install.packages("syuzhet")
install.packages("sentimentr")
library(tidyverse)
library(syuzhet)
#Remove URLs,mentones,and hastags
twitter_data_cleaned<-twitter%>%mutate(Content_clean=gsub("http\\S+|@\\S+|#[A-Za-z0-9]+","",Content))
#Check the clean content
head(twitter_data_cleaned$Content_clean)
#Get sentiment scores using syuzhet
twitter_data_cleaned$Sentiment_score<-get_sentiment(twitter_data_cleaned$Content_clean,method = "syuzhet")
#Preview the sentiment scores
head(twitter_data_cleaned$Sentiment_score)
#Summarize the sentiment data
sentiment_counts<-twitter%>%count(Sentiment)
#View the count of each sentiment
print(sentiment_counts)
#Vizualize Sentiment Distribution
ggplot(sentiment_counts,aes(x=Sentiment,y=n,fill=Sentiment))+geom_bar(stat="identity")+labs(title="Sentiment Distribution",x="Sentiment",y="Count")+theme_minimal()
#Analyze sentiment by entity
sentiment_entity<-twitter%>%group_by(Entity,Sentiment)%>%summarise(count=n())
print(sentiment_entity)
#Vizualize sentiment by entity
ggplot(sentiment_entity,aes(x=Entity,y=count,fill=Sentiment))+geom_bar(stat="identity",position = "dodge")+labs(title="Sentiment by Entity",x="Entity",y="Count")+theme_minimal()

