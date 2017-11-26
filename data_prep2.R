
rm(list = ls(all = T))
library(stringi)
library(stringr)
library(rjson)


#science space data. 
source_directory = paste(as.character(getwd()), "/webhose/entertainment", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
title_list = c()
stringlen = c()
for(i in 1:10000){
  current_list = fromJSON(file = all_files[i])
  current_string = paste(current_list$title, current_list$text[1])

  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
  title_list = append(title_list, current_list$title)
}

entertainment_data = data.frame(dataset_list, stringlen, title_list)
#entertainment_data = entertainment_data[which(entertainment_data$stringlen > 150),]
entertainment_data$label = "entertainment"
write.csv(entertainment_data, file = paste(getwd(), "/subsetdata/entertainment.csv", sep = ""), row.names = F)




#politics space data. 
rm(list = ls(all = T))
source_directory = paste(as.character(getwd()), "/webhose/politics", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
stringlen = c()
title_list = c()
for(i in 1:10000){
  current_list = fromJSON(file = all_files[i])
  current_string = paste(current_list$title, current_list$text[1])
  
  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
  title_list = append(title_list, current_list$title)
  
}

politics_data = data.frame(dataset_list, stringlen, title_list)
#politics_data = politics_data[which(politics_data$stringlen > 150),]
politics_data$label = "politics"
write.csv(politics_data, file = paste(getwd(), "/subsetdata/politics.csv", sep = ""), row.names = F)


#sports. 
rm(list = ls(all = T))
source_directory = paste(as.character(getwd()), "/webhose/sports", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
stringlen = c()
title_list = c()
for(i in 1:10000){
  current_list = fromJSON(file = all_files[i])
  current_string = paste(current_list$title, current_list$text[1])
  
  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
  title_list = append(title_list, current_list$title)
  
}

sports_data = data.frame(dataset_list, stringlen, title_list)
#sports_data = sports_data[which(sports_data$stringlen > 150),]
sports_data$label = "sports"
write.csv(sports_data, file = paste(getwd(), "/subsetdata/sports.csv", sep = ""), row.names = F)



#tech
rm(list = ls(all = T))
source_directory = paste(as.character(getwd()), "/webhose/Technology", sep="")
all_files = list.files(path = source_directory, full.names = T)

dataset_list = c()
stringlen = c()
title_list = c()
for(i in 1:10000){
  current_list = fromJSON(file = all_files[i])
  current_string = paste(current_list$title, current_list$text[1])
  
  current_string = trimws(current_string)
  dataset_list = append(dataset_list, current_string)
  stringlen = append(stringlen, str_count(current_string, " "))
  title_list = append(title_list, current_list$title)
  
}

tech_data = data.frame(dataset_list, stringlen, title_list)
#tech_data = tech_data[which(tech_data$stringlen > 150),]
tech_data$label = "tech"
write.csv(tech_data, file = paste(getwd(), "/subsetdata/tech.csv", sep = ""), row.names = F)


