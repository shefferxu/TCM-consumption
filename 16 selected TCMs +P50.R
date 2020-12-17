# RColorBrewer包使用
library("RColorBrewer")
display.brewer.all()  # 显示所有可用色板
display.brewer.all(type = "seq")  # 查看渐变色板
# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
scale_fill_manual(values=cbPalette)

# To use for line and point colors, add
scale_colour_manual(values=cbPalette)

library("ggplot2")
library("reshape")
mypath<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(mypath)
load("摄入情况表格.RData")
annual_intake <- as.data.frame(annual_intake)
annual_intake[,1:2]
h <- ggplot(data = annual_intake)+ geom_bar(stat = 'identity')
name <- rownames(annual_intake)
mean <- annual_intake$mean
P95 <- annual_intake$P95
P50 <- annual_intake$P50
df <- data.frame(name,mean,P50,P95)
windowsFonts(myFont = windowsFont("宋体"))



df <- df[1:16,]
df$name <- TCM <- c("A. membranaceus", "C. lacryma-jobi", "Z. jujuba", 
                    "A. macrocephala", "P. notoginseng", "S. miltiorrhiza", 
                    "P. ginseng", "L. Barbarum", "L. japonica", "O. japonicus",
                    "C. smyrnioides", "C. yanhusuo", "D. opposita", 
                    "S. baicalensis", "E. sinensis Walker", 
                    "C. morifolium")
df_melt <- melt(df,id="name")
df_melt$variable <- as.factor(df_melt$variable)
#柱形图更改坐标顺序
df_melt$name <- factor(df$name,levels =c("A. membranaceus", "C. lacryma-jobi", "Z. jujuba", 
                                         "A. macrocephala", "P. notoginseng", "S. miltiorrhiza", 
                                         "P. ginseng", "L. Barbarum", "L. japonica", "O. japonicus",
                                         "C. smyrnioides", "C. yanhusuo", "D. opposita", 
                                         "S. baicalensis", "E. sinensis Walker", 
                                         "C. morifolium"))



#plot
ggplot(data = df_melt, mapping = aes(x = factor(name), y = value,fill=variable)) +
  geom_bar(stat = 'identity', position = 'dodge')  +
  labs(x = "Name of TCM",
       y = "Annual Consumption(g)",
       title="") +
  labs(fill="Quantile")+  
  theme(axis.title = element_text(size = 8, family = "serif",  vjust = 0.5, hjust = 0.5))+
  theme(axis.text.x = element_text(size = 8, family = "serif",  vjust = 0.5, hjust = 0.5,angle = 45, face="italic"))+
  theme(axis.text.y = element_text(size = 8, family = "serif",  vjust = 0.5, hjust = 0.5))+
  scale_fill_manual(values=c("#a3a1a1","#333030","#2b90d9"))+
  theme(legend.title=element_text(size=8))+
  theme(legend.text=element_text(size=8))

#save plot

ggsave("selected TCMs.tiff", units="in", width=6, height=4, dpi=600)
