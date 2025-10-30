// ************************************************************************************************************************
// Created By:  Password's Team
// Worksheet:   Setup Tables Snowflake
// Usage:       This worksheet is used to Setup Tables
// ************************************************************************************************************************

// Creating Logistics Database
CREATE OR REPLACE DATABASE LOGISTICS;
USE DATABASE LOGISTICS;

// ALter Cross Region Inference
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';


// ************************************************************************************************************************
// Creating Gold Data Schema
CREATE OR REPLACE SCHEMA GOLD_DATA;
USE SCHEMA GOLD_DATA;

// Creating Cargo Container Post Arrival Check Table
create or replace TABLE LOGISTICS.GOLD_DATA.CARGO_CHECK_POST (
	DEFECTS VARCHAR(16777216),
	CONDITIONS VARCHAR(16777216),
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216)
);

// Creating Cargo Container Pre Arrival Check Table
create or replace TABLE LOGISTICS.GOLD_DATA.CARGO_CHECK_PRE (
	DEFECTS VARCHAR(16777216),
	CONDITIONS VARCHAR(16777216),
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216)
);

// Creating Customer Complaints Table
create or replace TABLE LOGISTICS.GOLD_DATA.CUSTOMER_COMPLAINTS (
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216),
	SHIPMENT_ID VARCHAR(16777216),
	COMPLAINT_TIME TIMESTAMP_NTZ(9),
	ISSUE_TYPE VARCHAR(16777216),
	DESCRIPTION VARCHAR(16777216)
);

// Creating Financial Expenditure Table
create or replace TABLE LOGISTICS.GOLD_DATA.FINANCIAL_EXPENDITURE (
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216),
	DEPARTURE_DATE TIMESTAMP_NTZ(9),
	ARRIVAL_DATE TIMESTAMP_NTZ(9),
	FUEL_COST NUMBER(38,2),
	MAINTENANCE_COST NUMBER(38,2),
	PORT_FEES NUMBER(38,2),
	CREW_COST NUMBER(38,2),
	INSURANCE_COST NUMBER(38,2),
	REVENUE NUMBER(38,0),
	PROFIT NUMBER(38,2)
);

// Creating Fuel Cost Logs Table
create or replace TABLE LOGISTICS.GOLD_DATA.FUEL_COST_LOGS (
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	ACTUAL_DEPARTURE TIMESTAMP_NTZ(9),
	ACTUAL_ARRIVAL TIMESTAMP_NTZ(9),
	AVG_SPEED_KNOTS NUMBER(38,2),
	KILOMETRES NUMBER(38,2),
	FUEL_USED_LITRES NUMBER(38,2),
	LITRES_PER_24KM NUMBER(38,2)
);

// Creating Incident Reports Table
create or replace TABLE LOGISTICS.GOLD_DATA.INCIDENT_REPORTS (
	ACTION_TAKEN VARCHAR(16777216),
	DATE DATE,
	IMPACT VARCHAR(16777216),
	INCIDENT_ID VARCHAR(16777216),
	PORT VARCHAR(16777216),
	RECOMMENDATION VARCHAR(16777216),
	REPORTED_BY VARCHAR(16777216),
	SUMMARY VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	WEATHER VARCHAR(16777216)
);

// Creating IOT Telemetry Table
create or replace TABLE LOGISTICS.GOLD_DATA.IOT_TELEMETRY (
	VESSEL_ID VARCHAR(16777216),
	TIMESTAMP TIMESTAMP_NTZ(9),
	ENGINE_RPM NUMBER(38,13),
	FUEL_USAGE_LPH NUMBER(38,15),
	VIBRATION_LEVEL NUMBER(38,16),
	TEMPERATURE_C NUMBER(38,14),
	LATITUDE NUMBER(38,17),
	LONGITUDE NUMBER(38,14),
	SPEED_KNOTS NUMBER(38,2)
);

// Creating Maintenance Check Table
create or replace TABLE LOGISTICS.GOLD_DATA.MAINTENANCE_CHECK (
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216),
	CHECK_TYPE VARCHAR(16777216),
	CHECK_TIMESTAMP TIMESTAMP_NTZ(9),
	VIBRATION_LEVEL_MM_S NUMBER(38,2),
	TEMPERATURE_C NUMBER(38,1),
	OIL_PRESSURE_BAR NUMBER(38,2),
	MACHINE_CONDITION VARCHAR(16777216),
	MAINTENANCE_RECOMMENDATION VARCHAR(16777216)
);

// Creating Maintenance Logs Table
create or replace TABLE LOGISTICS.GOLD_DATA.MAINTENANCE_LOGS (
	VESSEL_ID VARCHAR(16777216),
	MAINTENANCE_TIME TIMESTAMP_NTZ(9),
	ISSUE_TYPE VARCHAR(16777216),
	SEVERITY NUMBER(38,0)
);

// Creating Shipment Schedule Table
create or replace TABLE LOGISTICS.GOLD_DATA.SHIPMENT_SCHEDULE (
	SHIPMENT_ID VARCHAR(16777216),
	VESSEL_ID VARCHAR(16777216),
	CARGO_ID VARCHAR(16777216),
	DEPARTURE_TIME TIMESTAMP_NTZ(9),
	ETA TIMESTAMP_NTZ(9),
	ACTUAL_ARRIVAL TIMESTAMP_NTZ(9),
	WEATHER_CONDITION VARCHAR(16777216),
	ONGOING BOOLEAN,
	RESCHEDULED BOOLEAN
);

// Creating Crew Logs Transcribed Text Table
create or replace TABLE LOGISTICS.GOLD_DATA.TRANSCRIBED_TEXT (
	INCIDENT_ID VARCHAR(16777216),
	TEXT VARCHAR(16777216)
);

// Creating Weather Forecast Table
create or replace TABLE LOGISTICS.GOLD_DATA.WEATHER_FORECAST (
	FORECAST_CONDITION VARCHAR(16777216),
	TEMPERATURE_C FLOAT,
	WAVE_HEIGHT_M FLOAT,
	WEATHER_RISK_INDEX FLOAT,
	WIND_SPEED_KPH FLOAT,
	TIMESTAMP TIMESTAMP_NTZ(9)
);

// Creating Weather Observations Table
create or replace TABLE LOGISTICS.GOLD_DATA.WEATHER_OBSERVATION (
	VESSEL_ID VARCHAR(16777216),
	TIMESTAMP TIMESTAMP_NTZ(9),
	WEATHER_CONDITION VARCHAR(16777216),
	WIND_SPEED_KPH NUMBER(38,15),
	WAVE_HEIGHT_M NUMBER(38,16),
	TEMPERATURE_C NUMBER(38,15),
	WEATHER_RISK_INDEX NUMBER(38,18)
);


// Creating Internal Stages for Semantic Model
CREATE OR REPLACE STAGE LOGISTICS.GOLD_DATA.SEMANTIC_MODEL_STAGE
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// Creating Internal Stages for All CSV Data
CREATE OR REPLACE STAGE LOGISTICS.GOLD_DATA.CSV_FILES
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);

// ************************************************************************************************************************
// Creating Silver Data Schema
CREATE OR REPLACE SCHEMA SILVER_DATA;
USE SCHEMA SILVER_DATA;

// Creating Audio Files Raw Table
create or replace TABLE LOGISTICS.SILVER_DATA.AUDIO_FILES_RAW (
	RELATIVE_PATH VARCHAR(16777216),
	AUDIO_FILE FILE
);

// Creating Cargo Container Check Post Arrival Path Table
create or replace TABLE LOGISTICS.SILVER_DATA.CARGO_CHECK_POST_PATH (
	CARGO_CHECK_POST FILE,
	RELATIVE_PATH VARCHAR(16777216)
);

// Creating Cargo Container Check Pre Departure Path Table
create or replace TABLE LOGISTICS.SILVER_DATA.CARGO_CHECK_PRE_PATH (
	CARGO_CHECK_PRE FILE,
	RELATIVE_PATH VARCHAR(16777216)
);

// Creating Incident Reports Raw Table
create or replace TABLE LOGISTICS.SILVER_DATA.INCIDENT_REPORTS_RAW (
	IR_OBJECT VARIANT
);

// Creating Weather Forecast Raw Table
create or replace TABLE LOGISTICS.SILVER_DATA.WEATHER_FORECAST_RAW (
	ROW_JSON VARIANT
);

// Creating Internal Stages for Departure Cargo Defect Checking Images
CREATE OR REPLACE STAGE LOGISTICS.SILVER_DATA.CARGO_CHECK_PRE
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// Creating Internal Stages for Arrival Cargo Defect Checking Images
CREATE OR REPLACE STAGE LOGISTICS.SILVER_DATA.CARGO_CHECK_POST
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// Creating Internal Stages for Audio Data
CREATE OR REPLACE STAGE LOGISTICS.SILVER_DATA.AUDIO_TRANSCRIBE
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// Creating Internal Stages for Incident Reports
CREATE OR REPLACE STAGE LOGISTICS.SILVER_DATA.INCIDENT_REPORTS
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// Creating Internal Stages for All CSV Data
CREATE OR REPLACE STAGE LOGISTICS.SILVER_DATA.CSV_FILES
    ENCRYPTION = (TYPE='SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);


// ************************************************************************************************************************
// Setting Up Snowflake Intelligence & Doc AI
CREATE DATABASE IF NOT EXISTS SNOWFLAKE_INTELLIGENCE;
GRANT USAGE ON DATABASE SNOWFLAKE_INTELLIGENCE TO ROLE ACCOUNTADMIN;

CREATE SCHEMA IF NOT EXISTS SNOWFLAKE_INTELLIGENCE.AGENTS;
GRANT USAGE ON SCHEMA SNOWFLAKE_INTELLIGENCE.AGENTS TO ROLE ACCOUNTADMIN;

GRANT CREATE AGENT ON SCHEMA SNOWFLAKE_INTELLIGENCE.AGENTS TO ROLE ACCOUNTADMIN;

GRANT CREATE SNOWFLAKE.ML.DOCUMENT_INTELLIGENCE ON SCHEMA LOGISTICS.SILVER_DATA TO ROLE ACCOUNTADMIN;
GRANT CREATE MODEL ON SCHEMA LOGISTICS.SILVER_DATA TO ROLE ACCOUNTADMIN;
GRANT USAGE ON DATABASE LOGISTICS TO ROLE ACCOUNTADMIN;

// ************************************************************************************************************************
// Setting Up Email Integrations
USE DATABASE LOGISTICS;
USE SCHEMA SILVER_DATA;
create or replace notification integration email_integration
  type=email
  enabled=true
  default_subject = 'snowflake intelligence';

create or replace procedure send_email(
    recipient_email varchar,
    subject varchar,
    body varchar
)
returns varchar
language python
runtime_version = '3.12'
packages = ('snowflake-snowpark-python')
handler = 'send_email'
as
$$
def send_email(session, recipient_email, subject, body):
    try:
        # Escape single quotes in the body
        escaped_body = body.replace("'", "''")
        
        # Execute the system procedure call
        session.sql(f"""
            CALL SYSTEM$SEND_EMAIL(
                'email_integration',
                '{recipient_email}',
                '{subject}',
                '{escaped_body}',
                'text/html'
            )
        """).collect()
        
        return "Email sent successfully"
    except Exception as e:
        return f"Error sending email: {str(e)}"
$$;