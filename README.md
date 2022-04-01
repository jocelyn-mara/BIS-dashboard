# BIS-dashboard
This repository hosts all data and code files used to create a dashboard for assignment 1 of the Business Intelligence Systems PG unit at the University of Canberra. The dashboard is hosted on the shinyapps server and can be found [here](https://jmara4.shinyapps.io/shooting_dashboard_mockup/).

This repository contains the following files and directories:

- `helpers`: contains R script files that are sourced into the `shooting_dashboard_mockup.rmd` file when building the dashboard.
- `match_data`: contains csv files of the match data used to create the dashboard. Each csv file contains shot data for a single match, where each row/observation is a shot, and each column is a variable about that shot. 
- `models`: contains retrospective data and R code used to train a random forest model to create the Expected Goals algorithm, which is then applied to the match data during the dashboard build. 
- `out`: contains summarised and tidy data files that are outputs from the `shooting_dashboard_mockup.rmd` file. 
- `rsconnect`: contains the information used to deploy the dashboard to the shinyapps server. 
- `shooting_dashboard_mockup.rmd`: the R code file used to create the dashboard. This is the main program file. 
