SELECT Emplid, Name, Social, Start, End
FROM (
  SELECT [Connective_DB].emplid AS Emplid, [Mission_DB].name AS Name, [Mission_DB].social AS Social, [Mission_DB].start AS Start, [Mission_DB].end AS [End] 
  FROM Connective_DB 
  LEFT JOIN Mission_DB 
  ON [Connective_DB].social=[Mission_DB].social 
  WHERE [Mission_DB].social Is Not Null
  )  AS T1
WHERE T1.End >= #12/25/1991# AND T1.Emplid IN (SELECT emplid FROM [Personnel_DB]);
