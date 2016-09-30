x<-0:60
plot(x,dnorm(x,30,10), type="h", lwd=5, col="dodgerblue",xlab="count", ylab="probability", cex.lab=1, cex.main=1.7)
title(main="normal distribution\n(mean:30 / sd:10)", sub="")
text(45,0.035, expression(italic(f(x)==over(1,sqrt(2*pi*sigma^2))*e^(-over(-(x-mu)^2, 2*sigma^2)))),
                          cex=1.1)