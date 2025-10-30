// ************************************************************************************************************************
// Created By:  Password's Team
// Worksheet:   Weather Forecast
// Usage:       This worksheet is used to extract from JSON Format for Weather Forecast
// ************************************************************************************************************************

// Environment Setup
USE ROLE ACCOUNTADMIN;
USE DATABASE LOGISTICS;
USE SCHEMA SILVER_DATA;

// Select The JSON Table
SELECT *
FROM WEATHER_FORECAST_RAW;


// Extracting Data from JSON to Table 
INSERT INTO LOGISTICS.GOLD_DATA.WEATHER_FORECAST 
SELECT 
  ROW_JSON:"FORECAST_CONDITION"::VARCHAR AS FORECAST_CONDITION,
  ROW_JSON:"TEMPERATURE_C"::FLOAT AS TEMPERATURE_C,
  ROW_JSON:"WAVE_HEIGHT_M"::FLOAT AS WAVE_HEIGHT_M,
  ROW_JSON:"WEATHER_RISK_INDEX"::FLOAT AS WEATHER_RISK_INDEX,
  ROW_JSON:"WIND_SPEED_KPH"::FLOAT AS WIND_SPEED_KPH,
  ROW_JSON:"TIMESTAMP"::TIMESTAMP AS TIMESTAMP
FROM WEATHER_FORECAST_RAW;


// Showing the Results Table
SELECT *
FROM LOGISTICS.GOLD_DATA.WEATHER_FORECAST;