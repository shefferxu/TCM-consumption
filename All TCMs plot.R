library("ggplot2")
library("reshape")
options(scipen = 200)
All <- 
  read.csv2("D:/A长三院中药材/中药消费数据整理/三家药厂个人摄入量 (H_Name,ID_Name,Name).csv",
            header = T, sep =",",check.names=F)
All$`1年内摄入中药的量` <- as.numeric(All$`1年内摄入中药的量`)

All_vector <- as.vector(as.matrix(All$`1年内摄入中药的量`))
All_quantile <- c(quantile(All_vector, probs = c(0.05,0.5,0.95)), mean(All_vector))
tiff("All TCMs lzw.tiff", width = 6, height = 4, units = 'in', res = 600, compression = "lzw")
# plot
hist(All$`1年内摄入中药的量`,
        main="",
        xlab="Annual consumption(g)",ylab="Number of people",
        col = "darkgrey",border = "darkgrey",cex.axis=0.7,cex.lab=0.7,
        xlim=c(0,100000),ylim=c(0,60000),
        breaks = 250)

#画直线
abline(v = All_quantile,lty = 3,lwd = 2,col=c("green","yellow","red","orange"))
#加标注
A4<-paste(c("p5     ","p50   ","p95   ","mean"),
          c(round(All_quantile[1:2],0),round(All_quantile[3],0),round(All_quantile[4],0)),
          sep=":")
legend("topright",legend=A4, 
       col=c("green","yellow","red","orange"),lty=c(2,2,2,2),lwd=c(2,2,2,2),cex=0.5,bty = "o")
#线上写文字
text(c(All_quantile[1]-2.5*All_quantile[3]/50,
           All_quantile[2]+2.5*All_quantile[3]/30,
           All_quantile[4]+2.5*All_quantile[3]/20,
           All_quantile[3]-2.5*All_quantile[3]/30),
     60000,
     c("p5","p50","mean","p95"),cex=0.7)
dev.off()