-- {{ config(materialized='table') }}

SELECT
      _c0 AS First_Name
    , _c1 AS Last_Name
    , _c2 AS Email_Address
    , _c3 AS Company
    , _c4 AS Position
    , TO_DATE(_c5, 'dd MMM yyyy') AS Connected_On
    , input_file_name()           AS filename
FROM csv.`s3://propensity-to-buy/data/linkedin_contacts/raw/*.csv`
WHERE _c0 <> 'First Name' -- exclude header rows
