# install.packages('kohonen', repos='http://cran.ism.ac.jp/')
# library('kohonen')

# create data of users with (height, weight, iq, age)
height = as.integer(rnorm(1000, mean = 150, sd = 20))
weight = as.integer(rnorm(1000, mean=50, sd=15))
iq = as.integer(rnorm(1000, mean=100, sd=10))
age = as.integer(rnorm(1000, mean=40, sd=20))
users <- data.frame(height=height, weight=weight, iq=iq, age=age)
users <- as.matrix(scale(users))

# map users to 20x20 som grid
som_grid <- somgrid(xdim = 20, ydim=20, topo="rectangular")
som_model <- som(users, grid=som_grid, rlen=5000)

# show status
plot(som_model, type="changes")
plot(som_model, type="count")

# plot som heatmap
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
plot(som_model, type = "property", property = som_model$codes[,1], main=names(som_model$data)[1], palette.name=coolBlueHotRed)
plot(som_model, type = "property", property = som_model$codes[,2], main=names(som_model$data)[2], palette.name=coolBlueHotRed)
plot(som_model, type = "property", property = som_model$codes[,3], main=names(som_model$data)[3], palette.name=coolBlueHotRed)
plot(som_model, type = "property", property = som_model$codes[,4], main=names(som_model$data)[4], palette.name=coolBlueHotRed)
