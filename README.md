# ACT scores analsis
Tyler Cowen [wrote a post about ACT scores in West Virginia](http://marginalrevolution.com/marginalrevolution/2017/04/west-virginia-fact-day-comments.html), commenting on the fact that "West Virginia’s average ACT score and percentage taking the test are almost identical to the national average."

Upon inspection, it looked like the percentage of people who took the test in a given state strongly predicted average score;
given that, it was not particularly surprising that WV would fall in the middle of one category conidtional on falling in the middle of the other. I wrote a little bit of R code to demonstrate that. 

The relationship holds when you look both at all states and also those with less than 100% ACT takeup -- those in which the test is optional, I'm presuming.

It's a strong relationship, to say the least:
![with mandatory states taken out](https://github.com/setgree/ACT_score_analysis/blob/master/ACT_use_rates.png)


I created filepaths consistent with use for [Code Ocean](codeocean.com), where I will port this in time. 

