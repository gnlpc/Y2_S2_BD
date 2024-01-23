# Y2_S2_BD

Project done for the [FEUP Databses Courses](https://sigarra.up.pt/feup/en/UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=520317)

This project aimed to build a simple database for the Premier League season 2018/2019.

In order to get the data we used three free CSV's. We used scripts done in Python to get the information from the CSV and automatically write it in the populate file in SQL language. 

In this project we were asked in each step to integrate a generative AI in order to help us build our database. 


In order to run our project, create the database and see all data, we must first enter 
SQLite3 environment, and then create or open a database file. Firstly to create the tables we 
should run the command “:read create2.sql”, this will create the tables. After this we can run 
the command “:read populate2.sql” that will insert our data in the tables we previously 
created