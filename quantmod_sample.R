# install.packages('quantmod', repos='http://cran.ism.ac.jp/')
# install.packages('PerformanceAnalytics', repos='http://cran.ism.ac.jp/')

library(quantmod)
start = '2015-01-01'
end = '2015-12-31'
ticker = 'GOOG'
GOOG = getSymbols(ticker, src = 'yahoo', from = start, to = end, auto.assign=F)
AAPL = getSymbols('AAPL', src = 'yahoo', from = start, to = end, auto.assign=F)

# GOOGLEの株価プロット
chartSeries(GOOG)
# APPLEの株価プロット
chartSeries(AAPL)

# GOOGLE終値をプロット
plot(GOOG[,'GOOG.Close'], main='GOOG Closing Prices')

# 移動平均を計算
GOOG.index = index(GOOG)
GOOG.MVA = xts(filter(GOOG[,'GOOG.Close'], rep(1/10, 10), sides=1), order.by = GOOG.index)
GOOG.MVA20 = xts(filter(GOOG[,'GOOG.Close'], rep(1/20, 20), sides=1), order.by = GOOG.index)
GOOG.MVA50 = xts(filter(GOOG[,'GOOG.Close'], rep(1/50, 50), sides=1), order.by = GOOG.index)
GOOG.MVA100 = xts(filter(GOOG[,'GOOG.Close'], rep(1/100, 100), sides=1), order.by = GOOG.index)

# 移動平均をマージ
GOOG = merge(GOOG, GOOG.MVA, all=TRUE)
GOOG = merge(GOOG, GOOG.MVA20, all=TRUE)
GOOG = merge(GOOG, GOOG.MVA50, all=TRUE)
GOOG = merge(GOOG, GOOG.MVA100, all=TRUE)

# 移動平均線をプロット
plot.zoo(GOOG[,c('GOOG.Close', 'GOOG.MVA20', 'GOOG.MVA100')], plot.type = "single", col = c("red", "blue", "green"))

# 前日比を計算
GOOG.PREV_DAY_RATE = xts(GOOG[,'GOOG.Close'] / lag.xts(GOOG[,'GOOG.Close'], 1) - 1)
GOOG.PREV_DAY_RATE <- na.omit(GOOG.PREV_DAY_RATE)


motecarlo <- function (startPrice, days, mu, sigma) {
  dt = 1/days
  price = rep(1, days)
  price[1] <- startPrice
  drift <- mu * dt
  for (i in 2:(days)) {
    shock = sigma * rnorm(1) * sqrt(dt)
    price[i] <- price[i - 1] + price[i - 1] *( drift + shock)
  }
  return (price);
}

# 前日比のmu,sigmaを計算
days <- 365
mu <- mean(GOOG.PREV_DAY_RATE)
sigma <- sd(GOOG.PREV_DAY_RATE)

# 1年後までの株価を10回モンテカルロシミュレーション
fut <- c()
for(i in 1:10) {
  fut <-cbind(fut, motecarlo(524, 365,mu,sigma))
}

# プロット
fut.zoo = as.zoo(fut)
tsRainbow <- rainbow(ncol(fut))
plot(x = fut.zoo, ylab = "Cumulative Return", main = "Cumulative Returns",
     col = tsRainbow, screens = 1)

# 相関係数
start = '2015-01-02'
end = '2015-12-31'
GOOG = getSymbols('GOOG', src = 'yahoo', from = start, to = end, auto.assign=F)
AMZN = getSymbols('AMZN', src = 'yahoo', from = start, to = end, auto.assign=F)
MSFT = getSymbols('MSFT', src = 'yahoo', from = start, to = end, auto.assign=F)
AAPL = getSymbols('AAPL', src = 'yahoo', from = start, to = end, auto.assign=F)
head(GOOG)

GOOG.PREV_DAY_RATE = xts(GOOG[,'GOOG.Adjusted'] / lag.xts(GOOG[,'GOOG.Adjusted'], 1))
AMZN.PREV_DAY_RATE = xts(AMZN[,'AMZN.Adjusted'] / lag.xts(AMZN[,'AMZN.Adjusted'], 1))
MSFT.PREV_DAY_RATE = xts(MSFT[,'MSFT.Adjusted'] / lag.xts(MSFT[,'MSFT.Adjusted'], 1))
AAPL.PREV_DAY_RATE = xts(AAPL[,'AAPL.Adjusted'] / lag.xts(AAPL[,'AAPL.Adjusted'], 1))

hist(GOOG.PREV_DAY_RATE, breaks = 100)
hist(AMZN.PREV_DAY_RATE, breaks = 100)
ALL = merge(AAPL.PREV_DAY_RATE, AMZN.PREV_DAY_RATE,  GOOG.PREV_DAY_RATE,  MSFT.PREV_DAY_RATE, all= TRUE)
head(ALL)
tail(ALL)
ALL = na.omit(ALL)

cor(ALL)
library(PerformanceAnalytics)
chart.Correlation(ALL)

