#load data
library('caret', 'kernlab', 'RANN')
# set working directory
setwd("C:/Users/user/gitrep/pml_qsm/")

df.training <- read.csv('./Data/pml-training.csv')
df.testing <- read.csv('./Data/pml-testing.csv')

set.seed(579245)

# divide df.training dataset to a training and evaluation datasets
trainIn <- createDataPartition(df.training$classe, list=FALSE, p=0.75)
training = df.training[trainIn,]
evaluation = df.training[-trainIn,]

# remove nearZeroVar
nzvIn <- nearZeroVar(training)
training <- training[-nzvIn]
evaluation <- evaluation[-nzvIn]
df.testing <- df.testing[-nzvIn]

training[is.na(training)] <- 0
evaluation[is.na(evaluation)] <- 0
df.testing[is.na(df.testing)] <- 0

# remove remaining factor variables, these changes should not affect the analysis,
# names are tranformed to numeric IDs, and these dates are irrelevant to the analysis
training[,2] <- as.numeric(training[,2])
training$cvtd_timestamp <- NULL
evaluation[,2] <- as.numeric(evaluation[,2])
evaluation$cvtd_timestamp <- NULL
df.testing[,2] <- as.numeric(df.testing[,2])
df.testing$cvtd_timestamp <- NULL

# run PCA and prepare data
preProc <- preProcess(training[,-104], method='pca')
trainPC <- predict(preProc,training[,-104])
evalPC <- predict(preProc,evaluation[,-104])
testPC <- predict(preProc,df.testing[,-104])

# create random forest model
modelFit <- train(training$classe ~ ., method='rf',data=trainPC)
  
  # train random forest is a heavy operation, so use the model from file
  # dput(modelFit, file='./RCode/randForest_PCA.txt') 
  # in addition to that, this file is archived -- the original is ~100 MBt, now ~20MBts


# predict for evaluation dataset and testing (submission) dataset
evalPredict <- predict(modelFit,evalPC)
print(confusionMatrix(evalPredict, evaluation$classe))

testPredict <- predict(modelFit,testPC)


#prepare to submit ansers
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("./Data/","problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(as.character(testPredict))
