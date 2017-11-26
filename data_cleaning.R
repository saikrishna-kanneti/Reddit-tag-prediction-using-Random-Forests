setwd("C:/Users/kanne/Desktop")
rm(list = ls(all = T))

dataset = read.csv("combined_data.csv")
makesubset = function(data, count){
  subset_data = data.frame()
  class_names = unique(data$label)
  for(i in 1:length(class_names)){
    subset_data = rbind(subset_data, 
                        data[sample(which(data$label == class_names[i]), count),])
  }
  return(subset_data)
}


subset_data = makesubset(dataset, 10000)
library(tm)
subset_corpus = Corpus(VectorSource(subset_data$title_list))
subset_corpus = tm_map(subset_corpus, content_transformer(tolower))
subset_corpus = tm_map(subset_corpus, removeNumbers)
subset_corpus = tm_map(subset_corpus, removePunctuation)
subset_corpus = tm_map(subset_corpus, removeWords, c(stopwords("english")))
subset_corpus =  tm_map(subset_corpus, stripWhitespace)

dtm = DocumentTermMatrix(subset_corpus, control = list(weighting = weightTf, normalized = F))

review_dtm = removeSparseTerms(dtm, 0.995)
review_dtm = as.matrix(review_dtm)
names(data.frame(review_dtm))

library(xgboost)
targets = sapply(subset_data$label, function(x) ifelse(x == "entertainment", 0,
                                                       ifelse(x == "politics", 1,
                                                              ifelse(x == "sports", 2, 3))))
xgb_cvmodel = xgb.cv(as.matrix(review_dtm), label = targets, 
                     params = list("objective" = "multi:softprob", "eta" = 0.7, "num_class" = 4,"max_depth" = 15),
                     nrounds = 9999, nfold = 5, metrics = "merror", early_stopping_rounds = 150, print_every_n = 10, nthreads = 3)


setwd("/home/saikiran/hackathon/data/test_data")
test_data = read.csv("entertainment.csv")
test_data$original_label = "entertainment"

test_politics = read.csv("politics.csv")
test_politics$original_label = "politics"
test_data = rbind(test_data, test_politics)

test_sports = read.csv("sports.csv")
test_sports$original_label = "sports"

test_data = rbind(test_data, test_sports)

test_tech = read.csv("technology.csv")
test_tech$original_label = "technology"

test_data = rbind(test_data, test_tech)
test_corpus = Corpus(VectorSource(test_data$title_list))
test_corpus = tm_map(test_corpus, content_transformer(tolower))
test_corpus = tm_map(test_corpus, removeNumbers)
test_corpus = tm_map(test_corpus, removePunctuation)
test_corpus = tm_map(test_corpus, removeWords, c(stopwords("english")))
test_corpus =  tm_map(test_corpus, stripWhitespace)

test_dtm = DocumentTermMatrix(test_corpus, control = list(weighting = weightTf, normalized = F))
review_test_dtm = removeSparseTerms(test_dtm, 0.995)
review_test_dtm = as.matrix(review_test_dtm)

xgb.model = xgboost(as.matrix(review_dtm), label = targets, nrounds = 24,
                    params = list("objective" = "multi:softmax", "eta" = 0.7, "num_class" = 4,"max_depth" = 15))
predictions = predict(xgb.model, review_test_dtm )
test_data$original_label = sapply(test_data$original_label, function(x) ifelse(x == "entertainment", 0,
                                             ifelse(x == "politics", 1,
                                                    ifelse(x == "sports", 2, 3))))
library(caret)
confusionMatrix(predictions, test_data$original_label)


test_data$predicted_labels = predictions
write.csv(test_data, "test_data_withpredictions.csv", row.names = F)

test_data$predicted_labels = sapply(test_data$predicted_labels, function(x) ifelse(x == 0, "entertainment",
                                                                                 ifelse(x == 1, "politics",
                                                                                        ifelse(x == 2, "sports", 3))))