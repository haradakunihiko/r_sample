#install.packages('ggplot2', repos='http://cran.ism.ac.jp/')
#install.packages('ykmeans', repos='http://cran.ism.ac.jp/')
library(ggplot2)
library(ykmeans)

sample1 <- data.frame(x = rnorm(10, mean = 1, sd = 1), y = rnorm(10, mean = 1, sd = 1))
sample2 <- data.frame(x = rnorm(10, mean = 5, sd = 1), y = rnorm(10, mean = 5, sd = 1))
sample3 <- data.frame(x = rnorm(10, mean = 10, sd = 1), y = rnorm(10, mean = 10, sd = 1))
sample <- rbind(sample1, sample2, sample3)

head(sample)
ggplot(sample, aes(x=x, y=y)) + geom_point(size=1)
?ykmeans
ykm <- ykmeans(sample, c('x', 'y'), 'y', 3)
table(ykm$cluster)
ykm$cluster <- as.factor(ykm$cluster)
ggplot(ykm, aes(x=x,y=y, cpl=cluster, shape=cluster)) + geom_point(size=1)


newiris <- iris
newiris$Species <- NULL
head(newiris)
kc <- kmeans(newiris, 3)
table(iris$Species, kc$cluster)
plot(newiris[c("Sepal.Length", "Petal.Width")], col=kc$cluster)
