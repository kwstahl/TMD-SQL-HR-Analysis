# TMD SQL HR Analysis #

These SQL Queries were some of the first ones I did while working at the Texas Military Department. These are near and dear to my heart because they are what got me into Data Analysis in the first place.

Background: when I first started working at the Texas Military Department, a small team of HR analysts were manually checking thousands of rows of soldier data in an Oracle database. This was important, because soldiers needed to be correctly updated when on missions so that they could receive benefits, pay, and medical insurance. The process was tedious and time consuming, and the two databases to be checked against (Mission_DB and Personnel_DB) had no matching keys. Mission_DB used Social Security numbers, while Personnel_DB used Employee IDs. I was able to find a third database (Connective_DB) where I found both socials, and employee IDs. This was the key to streamlining the process. The SQL queries find all soldiers on mission, joins their social securities with their Employee IDs through Connective_DB, then finds soldiers that need to be added to mission on the personnel database, as well as those needing to be taken off. 


##Finding Soldiers to be Added to Personnel Database

###Join Personnel_DB with Mission_DB.
  
Since the Personnel DB uses Employee IDs (emplid) and the mission DB uses Socials, a new table must be made that connects the Mission DB through the Connective DB to pull socials matched up with the emplid. A left join is used to achieve this. 

Each soldier's name, start date, and end dates are also pulled from the Personnel DB. 

  `SELECT [Connective_DB].emplid AS Emplid, [Mission_DB].name AS Name, [Mission_DB].social AS     Social, [Mission_DB].start AS Start, [Mission_DB].end AS [End] 
  FROM Connective_DB LEFT JOIN Mission_DB ON [Connective_DB].social=[Mission_DB].social 
  WHERE [Mission_DB].social Is Not Null`
  
  The code above is aliased as "T1" for further manipulation.
  
###Select info from new table (T1) and Check if Exists/Date

`
SELECT Emplid, Name, Social, Start, End
 FROM  T1
 WHERE T1.Emplid NOT IN (SELECT emplid FROM Personnel_DB) and T1.End < #12/25/1991#;
 `

Now that the sub query is aliased, the Emplid, Name, Social, Start and End dates can be pulled from T1 and checked. Each Emplid inside the T1 sub-query is checked to see if it has been entered into the Personnel_DB, or not. The query also checks the end date: if the end date is less than "today's" date, then the record is pulled, otherwise, the record is filtered. This is because the soldier is already off of the mission (his end date is greater than today's date), then he does not need to be entered into the Personnel_DB. In fact, there is another set of queries to pull these soldiers that have never been entered, but that is a different issue.


##Find soldiers to be removed from mission on Personnel_DB

To find all soldiers that need to be removed from the Personnel_DB (i.e. their time is greater than "today's date", but they are still on the Personnel_DB), the process is essentially the same except for the difference that the script checks if each record is still in Personnel_DB, and if the time is greater than "today's" date.

SELECT Emplid, Name, Social, Start, End
FROM (
  SELECT [Connective_DB].emplid AS Emplid, [Mission_DB].name AS Name, [Mission_DB].social AS Social, [Mission_DB].start AS Start, [Mission_DB].end AS [End] 
  FROM Connective_DB 
  LEFT JOIN Mission_DB 
  ON [Connective_DB].social=[Mission_DB].social 
  WHERE [Mission_DB].social Is Not Null
  )  AS T1
WHERE T1.End >= #12/25/1991# AND T1.Emplid IN (SELECT emplid FROM [Personnel_DB]);



  
  
