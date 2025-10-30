// ************************************************************************************************************************
// Created By:  Password's Team
// Worksheet:   Incident Report Doc AI
// Usage:       This worksheet is used to extract data from Incident Reports PDF into Table Format
// ************************************************************************************************************************

// Environment Setup
USE ROLE ACCOUNTADMIN;
USE DATABASE LOGISTICS;
USE SCHEMA SILVER_DATA;

// Listing All Incident Reports
LIST @INCIDENT_REPORTS;


// Extracting Data From Incident Reports
INSERT INTO INCIDENT_REPORTS_RAW
SELECT IR_DOCAI!PREDICT(GET_PRESIGNED_URL(@INCIDENT_REPORTS, RELATIVE_PATH)) AS ir_object
FROM DIRECTORY(@INCIDENT_REPORTS);


// Looking at All the JSON Results
SELECT * FROM INCIDENT_REPORTS_RAW;


// Final Results of Parsing JSON Data
INSERT INTO LOGISTICS.GOLD_DATA.INCIDENT_REPORTS
SELECT
    IR_OBJECT:"ACTION_TAKEN"[0]."value"::varchar as ACTION_TAKEN,
    CONCAT(SUBSTR(IR_OBJECT:"DATE"[0]."value", 4,2), '/', LEFT(IR_OBJECT:"DATE"[0]."value",2), RIGHT(IR_OBJECT:"DATE"[0]."value",5))::date as DATE,
    IR_OBJECT:"IMPACT"[0]."value"::varchar as IMPACT,
    IR_OBJECT:"INCIDENT_ID"[0]."value"::varchar as INCIDENT_ID,
    IR_OBJECT:"PORT"[0]."value"::varchar as PORT,
    IR_OBJECT:"RECOMMENDATION"[0]."value"::varchar as RECOMMENDATION,
    IR_OBJECT:"REPORTED_BY"[0]."value"::varchar as REPORTED_BY,
    IR_OBJECT:"SUMMARY"[0]."value"::varchar as SUMMARY,
    IR_OBJECT:"VESSEL_ID"[0]."value"::varchar as VESSEL_ID,
    IR_OBJECT:"WEATHER"[0]."value"::varchar as WEATHER
FROM INCIDENT_REPORTS_RAW
ORDER BY INCIDENT_ID;


// Showing Results of IR
SELECT *
FROM LOGISTICS.GOLD_DATA.INCIDENT_REPORTS;