// ************************************************************************************************************************
// Created By:  Password's Team
// Worksheet:   Crew Logs Audio Transcribe
// Usage:       This worksheet is used to transcribe the audio of Crew Logs into Text
// ************************************************************************************************************************

// Environment Setup
USE ROLE ACCOUNTADMIN;
USE DATABASE LOGISTICS;
USE SCHEMA SILVER_DATA;

// Listing All Audio Files
LIST @AUDIO_TRANSCRIBE;


// Converting From List of Files into a String of Content
INSERT INTO AUDIO_FILES_RAW
  (SELECT REPLACE(RELATIVE_PATH, '.wav', '') as RELATIVE_PATH, TO_FILE('@AUDIO_TRANSCRIBE', RELATIVE_PATH) AS audio_file
   FROM DIRECTORY(@AUDIO_TRANSCRIBE));

// Transcribing Audio Files into Text
SELECT AI_TRANSCRIBE(audio_file) as "Transcribe" FROM AUDIO_FILES_RAW;


// Extracting the Conversation From Transcribed Text
INSERT INTO LOGISTICS.GOLD_DATA.TRANSCRIBED_TEXT
SELECT
    RIGHT(RELATIVE_PATH, 8) as INCIDENT_ID,
    "Transcribe":"text"::varchar as Text
FROM
    (SELECT RELATIVE_PATH, AI_TRANSCRIBE(audio_file) as "Transcribe" FROM AUDIO_FILES_RAW) as TRANSCRIBED_FILES;


// Showing The Results of Transcribed Text
SELECT *
FROM LOGISTICS.GOLD_DATA.TRANSCRIBED_TEXT;