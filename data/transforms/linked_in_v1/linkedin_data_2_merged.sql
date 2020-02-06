-- {{ config(materialized='table') }}
-- {{ config(location='s3://propensity-to-buy/data/linkedin/out/linkedin-spark-test.csv') }}

WITH linkedin_contacts_raw AS (
    SELECT * from linkedin_data_1_raw
)
SELECT
      replace(replace(replace(
          reverse(split(raw.filename, '/'))[0]
        , '.csv', '')
        , '_Connections', '')
        , '_', ' ')
      AS Slalom_Contact_Text
    , replace(replace(replace(
          reverse(split(raw.filename, '/'))[0]
        , '.csv', '')
        , '_Connections', '')
        , '_', ' ')
      + '::' + raw.Company
      + '::' + raw.First_Name + ' ' + raw.Last_Name
      + '::' + raw.Email_Address
      + '::' + CAST(raw.Connected_On as string)
      AS LinkedInConnectionId
    , raw.First_Name
    , raw.Last_Name
    , raw.Email_Address
    , raw.Company
    , raw.Position
    , raw.Connected_On
    , raw.filename                          AS filepath  -- 's3://...../AJ Steers.csv'
    , reverse(split(raw.filename, '/'))[0]  AS filename  -- 'AJ Steers.csv'
FROM linkedin_contacts_raw raw
