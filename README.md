# COVID-19 Tableau Project

## Problem Statement

The purpose of this project is to analyze historical data for COVID-19 infections since 2020. This project's dataset comes from ourworldindata.org

You can get insights on total deaths vrs total infections, infected population by country and infected population percentage forecast. I am including the four .xlsx files and the .sql

Link to visualization: https://public.tableau.com/app/profile/jose.franco8225/viz/CovidDashboard2024_17082426873070/Dashboard1.

### Steps followed 
- Step 1: Downloaded the most recent version of the dataset from: https://github.com/owid/covid-19-data/tree/master/public/data
- Step 2: Loaded the data into SSMS
- Step 3: Cleaned the data (data types, NULLS, etc). Utilized tools like alter tables, NULLIF, cast, among others.
- Step 4: Queried the data needed for the analysis (deathcount by country, continent; infections percentages)
![covidquery](https://github.com/TheDevFranco/DataAnalystProject_COVID19/assets/94664155/f8206437-1599-4c17-9329-e334319e6c2b)

- Step 5: Exported 4 queried tables as .xlsx Files 
- Step 6: Imported data to Tableau Public Desktop
- Step 7: Create Dashboards
![tableaudesktopcovid](https://github.com/TheDevFranco/DataAnalystProject_COVID19/assets/94664155/b34544ff-c406-4ac3-8610-ff4e4e502f32)
- Step 8: Publish to Tableau Public Online
