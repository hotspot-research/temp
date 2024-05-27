# NAME

## About

This is the official repository for the research paper *"NAME"*. The work addresses hotspot highlighting - receiving a hint as to what is interactive when clicking on a non-interactive part of the prototype. It investigates user behavior during prototype testing with different kinds of prototype fidelity in combination with hotspot highlighting.

### Paper citation

Not published yet.

### Contents

* [Dataset](#dataset)
* [Scripts](#scripts)
* [Extended results](#extended-results)
* [Experiment](#experiment)
* [Authors](#authors)
* [License](#license)

## Dataset

Data from 80 participants was collected via [UXtweak's user panel](https://www.uxtweak.com/user-participant-recruitment). [Raw data](./analysis/data/raw/) include non-edited data about respondents, their tasks and interaction data. Final dataset contains following files:
- [Clicks](./analysis/data/clicks.csv): Quantity of user clicks on specific elements on prototype screens during individual tasks.
- [Funnels](./analysis/data/funnels.csv): Quantity of transitions between prototype screens during individual tasks.
- [Interactions](./analysis/data/interactions.csv): Individual user clicks used to generate the heatmaps.
- [Respondents](./analysis/data/respondents.csv): Respondent data such as demographics.
- [Results](./analysis/data/respondents.csv): Results of individual tasks, including majority of analyzed variables.


## Scripts

See below for guidelines on configuring the virtual environment used for data analysis, an explanation of key scripts found in the file structure and resulting files.


### Environment 

All of the scripts located in the analysis folder are written using Python (version 3.12.1) and other external libraries installed using pip (version 24.0). Scripts were executed using jupyter notebooks in VS Code. A [requirements file](./analysis/requirements.txt) is provided for installing dependencies. After installing Python, the below commands can be used in the [analysis](./analysis/) directory to install the environment:
```
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

On macOS devices, this process could be slightly different:
```
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

This will create your virtual environment and install the dependencies. After the installation, notebooks could be executed in any available IDE (IDEs such as VS Code, in which the environment could be even installed automatically) or using the built-in web environment using this command in the command line (while having activated the virtual environment using `.venv\Scripts\activate` or `source .venv/bin/activate`):
```
jupyter notebook
```

Additionally, R language was also used. For executing the script, one has to have R installed, preferably with an IDE such as R studio in which the script can be launched.


### Files

Following files are present in the [scripts directory](/analysis/scripts):

- [Data preparation](/analysis/scripts/1_data-preparation.ipynb) of raw data files - data cleaning, column renaming and merging into resulting files, calculating metrics.
- [Data calculation](/analysis/scripts/1-2_data-calculation.ipynb)
- Exploratory data analysis of the dataset:
  - [Respondents data](/analysis/scripts/2-1_respondents_eda.ipynb).
  - [Results data](/analysis/scripts/2-2_results_eda.ipynb)
- [Hypothesis testing](/analysis/scripts/3_tests.R) - using statistical tests (in R)


## Extended results

### Statistical tests

Results of statistical tests are available in .csv format in [results directory](./analysis/results):
- [mann-whitney.csv](./analysis/results/mann-whitney.csv): Results of Mann-Whitney tests
- [chi2.csv](./analysis/results/chi2.csv): Results of Chi-squared tests of independence.
- [chi2_fit.csv](./analysis/results/chi2_fit.csv): Results of Chi-squared tests of goodness of fit.
- [normality.csv](./analysis/results/normality.csv): Results of Shapiro-Wilk tests of normality.

### Heatmaps

All relevant heatmaps are present in the [heatmaps directory](./heatmaps):

|Screen|Streamlined heatmap|Exploratory heatmap|
|---|---|---|
|HOME|[Task 1](./heatmaps/HOME-task1-streamlined.png), [Task 2](./heatmaps/HOME-task2-streamlined.png), [Task 3](./heatmaps/HOME-task3-streamlined.png)|[Task 1](./heatmaps/HOME-task1-exploratory.png), [Task 2](./heatmaps/HOME-task2-exploratory.png), [Task 3](./heatmaps/HOME-task3-exploratory.png)|
|TSHIRTS|[Task 1](./heatmaps/TSHIRTS-task1-streamlined.png), [Task 2](./heatmaps/TSHIRTS-task2-streamlined.png)|[Task 1](./heatmaps/TSHIRTS-task1-exploratory.png), [Task 2](./heatmaps/TSHIRTS-task2-exploratory.png)|
|TSHIRT|[Task 1](./heatmaps/TSHIRT-task1-streamlined.png), [Task 2](./heatmaps/TSHIRT-task2-streamlined.png)|[Task 1](./heatmaps/TSHIRT-task1-exploratory.png), [Task 2](./heatmaps/TSHIRT-task2-exploratory.png)|
|WISHLIST|[Task 2](./heatmaps/WISHLIST-task2-streamlined.png)|[Task 2](./heatmaps/WISHLIST-task2-exploratory.png)|
|CART|[Task 2](./heatmaps/CART-task2-streamlined.png)|[Task 2](./heatmaps/CART-task2-exploratory.png)|
|PROFILE-PURCHASES|[Task 3](./heatmaps/PROFILE_PURCHASES-task3-streamlined.png)|[Task 3](./heatmaps/PROFILE_PURCHASES-task3-exploratory.png)|
|PROFILE-RETURNS|[Task 3](./heatmaps/PROFILE_RETURNS-task3-streamlined.png)|[Task 3](./heatmaps/PROFILE_RETURNS-task3-exploratory.png)|


## Experiment

See below for additional experiment information not present in the article.

### Prototypes

Both Figma prototype variants are publicly available:
- [Streamlined variant](https://www.figma.com/proto/9MTV4BQNbyoBhAsB5j2qij/Hotspots-not-interactive?t=RLEEJ0FW7ruasofj-1&scaling=min-zoom&page-id=0%3A1&node-id=108-3618&starting-point-node-id=108%3A3618&show-proto-sidebar=1)
- [Exploratory variant](https://www.figma.com/proto/HumyDETYixChKKwf6W8KZi/Hotspots-interactive?node-id=1-502&t=pHdfKLfKXL5BX8zE-0&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=108%3A3618&show-proto-sidebar=1&hotspot-hints=0)


### Prototype usability issues
While the prototype is simply designed, multiple usability issues were introduced to simulate real usability testing conditions. These include, but are not limited to:
- Low readability of some items (e.g. low contrast, small font), such as header icons
- No “Add to cart” button, only wishlist icon and “Buy” button (which adds the item to the cart) on the product page
- Unnoticeable add to wishlist icon
- Missing notification after adding item to the cart
- Required registration for item purchase
- Insufficient payment methods on the payment page
- Unusual input labels on the payment page
- No price information is visible during purchase steps
- Additional fees displayed on the summary page, which were not mentioned before
- Wishlist and cart items are deleted after logging in
- Order ID has to be copied to return an item
- No option to return an item directly from purchases tab is available



### Task formulations
Prototype testing task formulations:

1. You’re browsing for an inexpensive T-shirt that you could come back to buy later. Choose the cheapest plain black T-shirt that you can find in the store and add it to your wish list.
2. Purchase the cheapest plain black T-shirt that you previously added to your wishlist.
3. You’ve received the package with the T-shirt you had ordered. While you have not opened the packaging yet, you’ve decided you would like to send it back. Request this via the store site.



### Questionnaires

|Initial questionnaire question|Type|Options|
|-|-|-|
|How old are you?|Single choice|18-27<br>28-37<br>38-47<br>48-57<br>58+|
|Which gender do you identify as?|Single choice|Man<br>Woman<br>Nonbinary|
|What is the highest education level you have completed?|Single choice|None completed<br>Secondary education<br>High school diploma<br>Technical/community college<br>Undergraduate degree<br>Graduate degree<br>Doctoral degree|
What is your personal income per year, after tax?|Single choice|No income<br>£0 - £9,999<br>£10,000 - £19,999<br>£20,000 - £29,999<br>£30,000 - £39,999<br>£40,000 - £49,999<br>£50,000 - £74,999<br>£75,000 - £100,000<br>More than £100,000|
|How often do you browse the web?|Single choice|For a significant part of the day<br>Few times a day<br>Few times a week<br>Few times a month<br>Less often or never|
|How often do you visit e-commerce websites (e-shops)?|Single choice|Daily<br>Several times a week<br>Once a week<br>Several times a month<br>Once a month<br>Every few months<br>Once a year<br>Less than once a year<br>Never|
|You may love pizza or ice cream. But when we ask you what you would order in the restaurant, you need to choose a salad. Based on the text above, what is a meal you would order in a restaurant?|Single choice|Pizza<br>Ice cream<br>Spaghetti<br>Salad<br>Fish and chips<br>Hamburger<br>Lasagna<br>Other|

|After-task question|Type|
|-|-|
|It was easy for me to complete the task.|1-7 Likert scale|
|I felt lost during the task, I was uncertain about where to click.|1-7 Likert scale|
|If you’ve encountered any issues while attempting to complete the task, describe here what happened.|Open-text|

|Final questionnaire question|Type|Options|
|-|-|-|
|Pixel Apparel store’s capabilities meet my requirements.|1-7 Likert scale||
|Using the Pixel Apparel store is a frustrating experience.|1-7 Likert scale||
|The Pixel Apparel store is easy to use.|1-7 Likert scale||
I have to spend too much time correcting things with the Pixel Apparel store.|1-7 Likert scale||
|How likely are you to recommend Pixel Apparel store to a friend or colleague?|0-10 scale||
|How many months are there in a year? Even though the correct answer is twelve, make sure to choose the option thirty.|Single choice|1<br>7<br>12<br>30<br>365<br>Other|
|While solving the tasks, did the prototype allow you to click everything that you expected to be clickable? If not, explain.|Open text|In the prototype, clickable areas flashed blue if you clicked an area that cannot be clicked. Choose all options that apply to you: (Multiple choice)<br>I have noticed the blue flashing areas.<br>I have used the blue flashing areas.<br>The blue flashing areas helped me complete the task more easily.<br>I sometimes deliberately clicked unrelated areas of the screen to make the blue flashing areas appear.<br>The blue flashing areas distracted me while navigating the prototype.<br>The blue areas flash too quickly.
|Is there anything else you’d like to tell us?|Open text||


### Experiment messages

**Welcome message:**

Welcome to this research study. Your response will help us to better understand how people use e-commerce websites.
The whole study shouldn't take longer than 15 minutes to complete. Please pay close attention to the instructions to ensure that your participation is valid. If asked to, please answer the questions in as much detail as you can. The more effort you make, the more useful your answers will be to us. Thanks for participating.

**Instructions:**

You will complete three tasks in total. All the tasks work as explained below:
1. You will be presented with a task.
2. After reading the task, you will be redirected to a prototype of an online clothing store.
3. Click through the prototype as you naturally would in order to complete the task.
4. Once you arrive at the screen where you are sure you have completed the task, click Done and the task will end.
5. After each task, you will be asked a couple of questions.

This is not a test of your ability, there are no right or wrong answers.
That’s it, let’s get started.


## Authors

### General contact 

Email: 
**hotspots.research@gmail.com**


**Eduard Kuric**\
He is a researcher and lecturer at [Faculty of Informatics and Information Technologies](https://www.fiit.stuba.sk/), [Slovak University of Technology in Bratislava](https://www.stuba.sk/). His research interests include human-computer interaction analysis, user modeling, personalized web-based systems, and machine learning. Eduard is also the head of the UX Research Department and the founder of [UXtweak](https://www.uxtweak.com/).
- [LinkedIn](https://www.linkedin.com/in/eduard-kuric-b7141280/)
- [Google Scholar](https://scholar.google.com/citations?user=MwjpNoAAAAAJ&hl=en&oi=ao)
- Email: eduard.kuric([AT])stuba.sk

**Peter Demcak**\
Researcher with background in software engineering, whose current topics of interest involve user behavior, human-computer interaction, UX research methods and design practices, and machine learning. Currently occupies the position of a scientific and user experience researcher at [UXtweak](https://www.uxtweak.com/), with focus on research that supports work of UX professionals.

- Email: peter.demcak([AT])uxtweak.com

**Matus Krajcovic**\
User experience researcher at [UXtweak](https://www.uxtweak.com/) and computer science student at [Faculty of Informatics and Information Technologies](https://www.fiit.stuba.sk/), [Slovak University of Technology in Bratislava](https://www.stuba.sk/). Currently focuses on data analysis and research in machine learning use in the field of human-computer interaction.
- [LinkedIn](https://linkedin.com/in/matus-krajcovic)
- Email: matus.krajcovic([AT])uxtweak.com


## License
This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).

[![Creative Commons License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)