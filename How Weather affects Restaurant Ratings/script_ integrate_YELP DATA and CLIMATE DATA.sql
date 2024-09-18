SELECT 
    r.review_id,
    r.user_id,
    r.business_id,
    r.stars,
    r.useful,
    r.funny,
    r.cool,
    r.text,
    r.timestamp,
    t.temp_min,
    t.temp_max,
    p.precipitation
FROM 
    review r
LEFT JOIN 
    temperature t
ON 
    DATE(r.timestamp) = t.date
LEFT JOIN 
    precipitation p
ON 
    DATE(r.timestamp) = p.date
WHERE 
    r.timestamp IS NOT NULL;
