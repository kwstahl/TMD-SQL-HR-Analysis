# TMD SQL HR Analysis
These SQL Queries were some of the first ones I did while working at the Texas Military Department. These are near and dear to my heart because they are what got me into Data Analysis in the first place.

Background: when I first started working at the Texas Military Department, a small team of HR analysts were manually checking thousands of rows of soldier data in an Oracle database. This was important, because soldiers needed to be correctly updated when on missions so that they could receive benefits, pay, and medical insurance. The process was tedious and time consuming, and the two databases to be checked against (Mission_DB and Personnel_DB) had no matching keys. Mission_DB used Social Security numbers, while Personnel_DB used Employee IDs. I was able to find a third database (Connective_DB) where I found both socials, and employee IDs. This was the key to streamlining the process.

The SQL queries find all soldiers on mission, joins their social securities with their Employee IDs through Connective_DB, then finds soldiers that need to be added to mission on the personnel database, as well as those needing to be taken off. 
