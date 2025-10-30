// ************************************************************************************************************************
// Created By:  Password's Team
// Worksheet:   Pre Departure Cargo Container Condition Check
// Usage:       This worksheet is used to check Cargo Container Condition Pre Departure
// ************************************************************************************************************************

// Environment Setup
USE ROLE ACCOUNTADMIN;
USE DATABASE LOGISTICS;
USE SCHEMA SILVER_DATA;

// Listing All Container Files
LIST @CARGO_CHECK_PRE;


// Converting From List of Files into a String of Content
INSERT INTO CARGO_CHECK_PRE_PATH
  (SELECT TO_FILE('@CARGO_CHECK_PRE', RELATIVE_PATH) AS CARGO_CHECK_PRE,
  RELATIVE_PATH as RELATIVE_PATH
   FROM DIRECTORY(@CARGO_CHECK_PRE));


// Checking Cargo Container Defect from Images
SELECT AI_COMPLETE('claude-4-sonnet', 'Can you tell me the kind of defects like a hole, a scratch, etc and what is the conditions, make it concise and dont add any more information in this format: Defects: A Huge Hole | Conditions: (Good to Go is when its all clear, Need Maintenance if there are heavy rust, Critical Conditions if there is a hole or clear scratch)', CARGO_CHECK_PRE) as "Parsed" FROM CARGO_CHECK_PRE_PATH;


// Inserting Data into Cargo Check Table
INSERT INTO LOGISTICS.GOLD_DATA.CARGO_CHECK_PRE
SELECT 
    TRIM(SPLIT_PART(SPLIT_PART(Text, '|', 1), ':', 2)) AS DEFECTS,
    TRIM(SPLIT_PART(SPLIT_PART(Text, '|', 2), ':', 2)) AS CONDITIONS,
    LEFT(RELATIVE_PATH, 16) as SHIPMENT_ID,
    SUBSTR(RELATIVE_PATH, 19, 7) as VESSEL_ID,
    SUBSTR(RELATIVE_PATH, 28, 7) as CARGO_ID,
FROM (SELECT
    "Parsed" as Text,
    RELATIVE_PATH as RELATIVE_PATH
FROM
    (SELECT AI_COMPLETE('claude-4-sonnet', 'Can you tell me the kind of defects like a hole, a scratch, etc and what is the conditions, make it concise and dont add any more information in this format: Defects: A Huge Hole | Conditions: (Good to Go is when its all clear, Need Maintenance if there are heavy rust, Critical Conditions if there is a hole or clear scratch)', CARGO_CHECK_PRE) as "Parsed", RELATIVE_PATH FROM CARGO_CHECK_PRE_PATH) as DEFECT_CONTAINER);


// Showing The Results of Cargo Container Check
SELECT *
FROM LOGISTICS.GOLD_DATA.CARGO_CHECK_PRE;