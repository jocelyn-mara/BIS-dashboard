# Code to create a model to determine the probability of a goal
# being scored based on the x,y coordinates of where the shot was
# taken, as well as the distance to goal.
# All pre-processing has already been conducted. 

# ~~~~~~~~~~~~~~~~~~~~~~~~~LOAD PACKAGES~~~~~~~~~~~~~~~~~~~~~#
# Install 'tidyverse', 'caret'  packages if not already installed.
library(tidyverse)
library(caret)

# ~~~~~~~~~~~~~~~~~~~~~~~~~READ DATA~~~~~~~~~~~~~~~~~~~~~~~~#

# Read in the training data using the path_to_file object created
# in the previous step.
df <- read_csv("models/train.csv") %>%
  # convert the outcome variable to a factor with 'Goal' as 
  # the positive level.
  mutate(outcome = factor(outcome, levels = c("Goal", "NoGoal")))

# select just the variables of interest to train the model
train_data <- df %>% 
  select(x, y0, outcome)

# ~~~~~~~~~~~~~~~~~~~~~~MODEL TRAINING~~~~~~~~~~~~~~~~~~~~~~~~~#

# Create an object to set the options for the cross validation
# I will just use 5-fold cross validation to save time with the random forest
control_obj <- trainControl(
  method = 'cv',                     # k-fold cross validation
  number = 5,                        # number of folds
  savePredictions = 'final',         # saves predictions for optimal tuning parameter
  classProbs = TRUE,                 # should class probabilities be returned
  summaryFunction = twoClassSummary  # results summary function
) 

# set seed for reproducibility
set.seed(616) # if you're a marvel fan, you'll get it

# train a random forest to predict the shot outcome by all other
# variables in the new_train data
goal_model <- train(outcome ~ ., data = train_data,
                    method = "rf",
                    trControl = control_obj,
                    verbose = FALSE)

# print the goal_model if you want to take a look:
#goal_model

# Save the model object as an .rds so we can load it and use it
# later without having to train the model again.

saveRDS(goal_model, "models/goal_model.rds")

# ~~~~~~~~~~~~~~~~~~~~~~VISUALISATION~~~~~~~~~~~~~~~~~~~~~~~~~#

# To visualise the goal probabilities based on the features use:

# Apply the model to the data to calculate the goal probabilities
probs <- predict(goal_model, newdata = df, type = "prob") %>%
  # select just the goal probabilities, and remove NoGoal probabilites
  select(Goal) %>%
  # convert from dataframe to a "flat" vector
  unlist() %>%
  # remove the rownames
  unname()

# Attach the probs object to df as a new variable
df <- df %>%
  mutate(goal_probs = probs)


# create visualisation of goal_probs 
ggplot(data = df, aes(x = x, y = y, colour = probs)) +
  geom_point()


# Note the collection of shots from outside the 18-yard box
# that all have high probabilites. 
# This is likely due to the knn from the smote as there were some
# actual goals that were scored from out there. 