# data taken from https://magoosh.com/hs/act/2016/average-act-score-by-state/
# column heads were hard to grab, I imputed them manually

# pacman is a syntactically elegant way to upload packages that I like
# uncomment next line if you haven't installed it already
# install.packages("pacman")
pacman::p_load(tidyverse, ggrepel, lmtest, car)

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

# Is heteroskedasticity a problem? Certainly looks like it
pdf(file = "../output/PlotFits.pdf")
par(mfrow=c(2,2))
 plot(model)
dev.off()

lmtest::bptest(model) # eh
car::ncvTest(model) # eh

# What about states that don't have 100% testing? 

ACT_optional <- ACT %>%
  filter(percent_tested < 100)

# Repeat the analysis 
model_optional <- lm(formula = avg_score ~ percent_tested, data = ACT_optional)
summary(model_optional)

ggplot(data = ACT_optional, mapping = aes(x = percent_tested, 
                                 y = avg_score)) +
  geom_point() +
  geom_smooth(method = "lm") + 
  geom_text_repel(aes(label = state)) +
  labs(x = "Percent Tested", y = "Average Score", 
       title = "Percent Tested vs. Average Score") + 
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "../output/ACT_optional_plot.pdf") 

lmtest::bptest(model_optional) # worse but not crazy
car::ncvTest(model_optional) # same
