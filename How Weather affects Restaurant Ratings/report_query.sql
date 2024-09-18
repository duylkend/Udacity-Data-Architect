USE DATABASE "UDACITYPROJECT";
USE SCHEMA "UDACITYPROJECT"."DATAWAREHOUSE";

SELECT 
	fr.date, db.name, db.city, db.state,
	dte.precipitation, dte.precipitation_normal, 
	AVG(fr.stars) AS avg_stars, 
	dte.temp_min, dte.temp_max
FROM fact_review fr
LEFT JOIN dim_business db  
	ON fr.business_id = db.business_id
LEFT JOIN dim_weather dte 
	ON fr.date = dte.date
GROUP BY fr.date, db.name, dte.temp_min, dte.temp_max, 
	dte.precipitation, dte.precipitation_normal, 
	db.city, db.state
ORDER BY fr.date DESC;