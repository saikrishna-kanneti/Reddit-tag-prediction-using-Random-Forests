# Reddit-tag-prediction-using-Random-Forests


Inspiration:
The titles of posts are so similar that it is difficult to comprehend what is the post about.
This inspired us to solve this problem using machine learning to tag posts automatically.


What it does: 
It scrapes Reddit and tags the posts relevantly.


How we built it :
We used python to scrape the data. R for Machine Learning and Flask for presenting the data with tags.


Challenges we ran into : 
The "correct" kind of data collection for such a problem for training the model is hard.
For most of the posts you cannot figure out if it has text or only video -- For the posts with video you cannot scrape it to predict on it.
From the papers that we read, solving a given NLP problem is a research problem in itself since the data is not the same as they say in 
the paper to approach the problem in a similar way.
