library(ggmap)

RouteData <- route(from = "東京駅", to = "米子", mode = "driving",
                   structure = "route", output = "simple")

qmap("kanazawa", zoom = 6) +
  geom_path(data = RouteData, aes(x = lon, y = lat),
            colour = "red", size = 1.5, lineend = "round")
