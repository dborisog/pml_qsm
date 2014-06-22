Title: Qualitative activity recognition of the unilateral dumbbell biceps curl, a course project of Practical Machine Learning, June 2014.
========================================================
Author: Dmitry Borisoglebsky

Github: https://github.com/dborisog/pml_qsm

Introduction
============
This report finalizes a course project of Practical Machine Learning June 2014 [1], a course delivered by staff of John Hopkins University Jeff Leek, Brian Caffo, and Roger D. Peng via Coursera. This course project was inspired by a human activity recognition (HAR) project [2 , 3].

This HAR project was researching qualitative physical activity recognition, in different words how well an activity was executed. Six young adults were executing ten repetition of the unilateral dumbbell biceps curl in five manners: (A) exactly according to the specification, (B) throwing the elbows to the front, (C) lifting the dumbbell only halfway, (D) lowering the dumbbell only halfway, (E) throwing the hips to the front, where B  E represent common mistakes. These executions were recorded via four sensors on the belt, arm, forearm, and dumbbell.

Data from this HAR project was delivered to the course students in two datasets, a training dataset of 19622 observations and 158 variables plus a manner 'classe' variable, and a testing dataset of 20 observations and 158 variables without 'classe' variable. The course project's objective is to predict the manner 'classe' of the testing dataset.

Methods
=======
Specifics of the objective and the course limit methods could be applied by the author. The major part of the design of experiment was defined by the HAR project researchers, the HAR project's objective was set, exercise and types of mistakes were chosen, means to collect the data were selected, and data was collected. This course project also de facto narrows down the analytical means leaving methods that have been mentioned within the course: data preprocessing, modeling and prediction, analysis organization and sharing.

Data pre-processing. Training dataset is relatively large to split into training and evaluation datasets in proportion 75% and 25%, respectively. The number of variables is relatively large to assume that some variables might be excluded without loosing on variability and accuracy, near to zero variable and non-principle components were identified and filtered out.

Modeling and prediction. Having the manners 'classe' variable within the original training dataset and the qualitative nature of 'classe' variable focuses the author on classification and algorithms. Random forest is one of the most accurate classification algorithm, the author assumed that this algorithm would allow to create a model for the data on his desktop PC, and thereby selected random forests for modeling and prediction.

Reproduction. The course project assumes that the predicted results and report would be submitted on Coursera website for further evaluation, and the project's files would be available online via Github. The file organization structure proposed by the teaching personal of this and other data analysis MOOC from John Hopkins University was used in this project.

R scripting language and 'caret' package were major major preprocessing and analysis tools used in this project.

Results
=======
Data preprocessing are possible to find in the appendix and '\RCode\script.R' file of the github repository. 
'confusionMatrix' function of 'caret' package produces the following output for predicted and actual values of 'classe' variable of evaluation dataset.


```r
print(confusionMatrix(evalPredict, evaluation$classe))
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1388    8    2    1    0
##          B    1  934    8    3    2
##          C    1    5  841   15    0
##          D    1    2    2  783    3
##          E    4    0    2    2  896
## 
## Overall Statistics
##                                        
##                Accuracy : 0.987        
##                  95% CI : (0.984, 0.99)
##     No Information Rate : 0.284        
##     P-Value [Acc > NIR] : < 2e-16      
##                                        
##                   Kappa : 0.984        
##  Mcnemar's Test P-Value : 0.00571      
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.995    0.984    0.984    0.974    0.994
## Specificity             0.997    0.996    0.995    0.998    0.998
## Pos Pred Value          0.992    0.985    0.976    0.990    0.991
## Neg Pred Value          0.998    0.996    0.997    0.995    0.999
## Prevalence              0.284    0.194    0.174    0.164    0.184
## Detection Rate          0.283    0.190    0.171    0.160    0.183
## Detection Prevalence    0.285    0.193    0.176    0.161    0.184
## Balanced Accuracy       0.996    0.990    0.989    0.986    0.996
```

The prediction for testing dataset are shown in the following script.

```r
predict(modelFit,testPC)
```

```
##  [1] B A A A A B A B A A B A B A B A A B B B
## Levels: A B C D E
```

Discussion and conclusions
===========================
The confusionMatrix' output shows that the developed classification model delivers accurate results, even better results than in the original research [3], see confusion matrix and other parameters. Assuming that training, evaluation, and testing datasets share the same bias, it is possible to conclude that predictions are accurate as well.

References
==========
 1  https://www.coursera.org/course/predmachlearn, accessed 2014-06-22. 
 
 2  http://groupware.les.inf.puc-rio.br/har, accessed 2014-06-22.
 
 3  Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th Augmented Human (AH) International Conference in cooperation with ACM SIGCHI (Augmented Human'13) . Stuttgart, Germany: ACM SIGCHI, 2013. 
