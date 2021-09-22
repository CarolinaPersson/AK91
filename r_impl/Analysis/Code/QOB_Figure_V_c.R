################################################################################
#                                     FIGURE V Replication AK91                      
#                                         VERSION: R 4.0.5
#                                         DATE: 2021-09-21
#                                         CAROLINA PERSSON
#
################################################################################

rm(list=ls())

#### Import data from Analysis/Input

df<-import("./Analysis/Input/Figure_V_Data_Set.dta")

#### Create the mean of the log weekly wage

mean_LWKLYWGE <- df %>%
  mutate(YOB=ifelse(YOB>1900,YOB-1900,YOB)
         ,YOBQ=YOB+0.25*(QOB-1)) %>%
  filter(YOB>=30) %>%
  group_by(YOB,QOB,YOBQ) %>% 
  summarize(
    M_LWKLYWGE=mean(lnweeklywage)
  )

#### Create Plot

jpeg("Analysis/Output/Figure_V.jpg")
ggplot(data=mean_LWKLYWGE) + 
  geom_point(mapping=aes(x=YOBQ,y=M_LWKLYWGE,color=QOB==1),show.legend = FALSE) +
  geom_text(aes(x=YOBQ,y=M_LWKLYWGE,label=QOB),hjust=0, vjust=0) +
  labs(y= "Log of Weekly wages (mean)", x = "Year of Birth")
dev.off()

################################################################################
