# data taken from https://magoosh.com/hs/act/2016/average-act-score-by-state/

# pacman is a syntatically elegant way to upload packages that I like
# uncomment next line if you haven't installed it already
#install.packages("pacman")
pacman::p_load(tidyverse, ggrepel)

# let's look at all data
ACT <- read.table(file = "../input/ACT.tsv", sep =  '\t', header = FALSE)
colnames(ACT) = c("state", "percent_tested", "avg_score", "Met_Eng_Bench",
                  "Met_Read_Bench", "Met_Math_Bench", "Met_Sci_Bench")
summary(ACT)
model <- lm(formula = avg_score ~ percent_tested, data = ACT)
summary(model)

ggplot(data = ACT, mapping = aes(x = percent_tested, 
                                 y = avg_score)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  geom_text_repel(aes(label = state)) +
  labs(x = "Percent Tested", y = "Average Score", 
       title = "Percent Tested vs. Average Score") + 
  theme(plot.title = element_text(hjust = 0.5))
 ggsave(filename = "../output/ACT_plot.pdf") 



dev.off()

# What about states that don't have 100% testing? 

ACT_optional <- ACT %>%
  filter(percent_tested < 100)

# Then do the same analysis
model <- lm(formula = avg_score ~ percent_tested, data = ACT_optional)
summary(model)

ggplot(data = ACT_optional, mapping = aes(x = percent_tested, 
                                 y = avg_score)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  geom_text_repel(aes(label = state)) +
  labs(x = "Percent Tested", y = "Average Score", 
       title = "Percent Tested vs. Average Score") + 
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "../output/ACT_optional_plot.pdf") 
dev.off()