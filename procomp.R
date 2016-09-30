data(iris)
data <- iris[1:4]
head(iris)
prcomp.obj <- prcomp(data, scale=TRUE) # 主成分分析
pc1 <- prcomp.obj$x[,1] # 第一主成分得点
pc2 <- prcomp.obj$x[,2] # 第二主成分得点
label <- as.factor(iris[,5]) 

percent <- summary(prcomp.obj)$importance[3,2] * 100
plot(pc1, pc2, col = label, main = paste(percent, "%"))
