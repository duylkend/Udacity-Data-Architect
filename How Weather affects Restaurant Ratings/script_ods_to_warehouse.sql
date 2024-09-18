USE DATABASE "UDACITYPROJECT";
USE SCHEMA "UDACITYPROJECT"."DATAWAREHOUSE";

CREATE OR REPLACE TABLE dim_weather (
    date DATE PRIMARY KEY,
    temp_min FLOAT,
    temp_max FLOAT,
    temp_normal_min FLOAT,
    temp_normal_max FLOAT,
	precipitation FLOAT,
    precipitation_normal FLOAT
);

CREATE OR REPLACE TABLE dim_user (
    user_id TEXT PRIMARY KEY,
    name TEXT,
    review_count INT,
    yelping_since DATETIME,
    useful              INT,
    funny               INT,
    cool                INT,
    elite               TEXT,
    friends             TEXT,
    fans                INT,
    average_stars NUMERIC(3,2),
    compliment_hot      INT,
    compliment_more     INT,
    compliment_profile  INT,
    compliment_cute     INT,
    compliment_list     INT,
    compliment_note     INT,
    compliment_plain    INT,
    compliment_cool     INT,
    compliment_funny    INT,
    compliment_writer   INT,
    compliment_photos   INT
);

CREATE OR REPLACE TABLE dim_business (
    business_id TEXT PRIMARY KEY,
    name TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    latitude FLOAT,
    longitude FLOAT,
    stars NUMERIC(3,2),
    review_count INT,
    is_open INT,
    attributes OBJECT,
    categories TEXT,
    hours VARIANT,
    checkin_date TEXT,
    covid_highlights                TEXT,
    covid_delivery_or_takeout       TEXT,
    covid_grubhub_enabled           TEXT,
    covid_call_to_action_enabled    TEXT,
    covid_request_a_quote_enabled   TEXT,
    covid_banner                    TEXT,
    covid_temporary_closed_until    TEXT,
    covid_virtual_services_offered  TEXT
);

CREATE OR REPLACE TABLE fact_review (
    review_id           TEXT        PRIMARY KEY,
    user_id             TEXT,
    business_id         TEXT,
    stars               NUMERIC(3,2),
    useful              BOOLEAN,
    funny               BOOLEAN,
    cool                BOOLEAN,
    text                TEXT,
    date                DATE,
    CONSTRAINT FK_US_ID FOREIGN KEY(user_id)        REFERENCES  dim_user(user_id),
    CONSTRAINT FK_BU_ID FOREIGN KEY(business_id)    REFERENCES  dim_business(business_id)
);

BEGIN TRANSACTION;
    DELETE FROM fact_review;
    DELETE FROM dim_business;
    DELETE FROM dim_user;
    DELETE FROM dim_weather;
COMMIT;

/* INSERT DATA TO TABLE */
INSERT INTO dim_business(business_id ,name ,address ,city, state, postal_code, latitude, longitude , stars, review_count, is_open, attributes, categories, hours, checkin_date, covid_highlights, covid_delivery_or_takeout,
covid_grubhub_enabled, covid_call_to_action_enabled, covid_request_a_quote_enabled, covid_banner, covid_temporary_closed_until, covid_virtual_services_offered)
SELECT 
    bu.business_id,
    bu.name,
    bu.address,
    bu.city,
    bu.state,
    bu.postal_code,
    bu.latitude,
    bu.longitude,
    bu.stars,
    bu.review_count,
    bu.is_open,
    bu.attributes,
    bu.categories,
    bu.hours,
    ch.date,
    co.highlights,
    co.delivery_or_takeout,
    co.grubhub_enabled,
    co.call_to_action_enabled,
    co.request_a_quote_enabled,
    co.covid_banner,
    co.temporary_closed_until,
    co.virtual_services_offered
FROM "UDACITYPROJECT"."ODS".business bu
LEFT JOIN "UDACITYPROJECT"."ODS".checkin ch 
	ON bu.business_id = ch.business_id
LEFT JOIN "UDACITYPROJECT"."ODS".covid co 
	ON bu.business_id = co.business_id;

INSERT INTO dim_user(user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends, fans, average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute, compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny, compliment_writer, compliment_photos)
SELECT 
    us.user_id,
    us.name,
	us.review_count,
	us.yelping_since,
    us.useful,
    us.funny,
    us.cool,
	us.elite,
    us.friends,
	us.fans,
    us.average_stars,
    us.compliment_hot,
    us.compliment_more,
    us.compliment_profile,
    us.compliment_cute,
    us.compliment_list,
    us.compliment_note,
    us.compliment_plain,
	us.compliment_cool,
	us.compliment_funny,
	us.compliment_writer,
	us.compliment_photos	
FROM "UDACITYPROJECT"."ODS".user us;

INSERT INTO fact_review (review_id, user_id, business_id, stars, useful, funny, cool, text, date)
SELECT  re.review_id,
        re.user_id,
        re.business_id,
        re.stars,
        re.useful,
        re.funny,
        re.cool,
        re.text,
        DATE(re.timestamp)
FROM "UDACITYPROJECT"."ODS".review re;

INSERT INTO dim_weather (date, temp_min, temp_max, temp_normal_min, temp_normal_max, precipitation, precipitation_normal)
SELECT 
	te.date, te.temp_min, te.temp_max, te.temp_normal_min, te.temp_normal_max, pr.precipitation, pr.precipitation_normal
FROM "UDACITYPROJECT"."ODS".temperature te
JOIN "UDACITYPROJECT"."ODS".precipitation pr 
ON pr.date = te.date;


