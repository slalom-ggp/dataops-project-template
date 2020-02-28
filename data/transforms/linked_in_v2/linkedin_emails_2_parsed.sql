WITH csv_rows AS
(
    SELECT
          explode(split(connections_csv_file, '\n')) as csv_row
        , Sender_Name
        , Send_Date
        , Email_Filename
    FROM linkedin_emails_1_raw
)
SELECT
      split(csv_row, ',')[0] AS First_Name
    , split(csv_row, ',')[1] AS Last_Name
    , split(csv_row, ',')[2] AS Email_Address
    , split(csv_row, ',')[3] AS Company
    , split(csv_row, ',')[4] AS Position
    , Sender_Name
    , Send_Date
    , Email_Filename
    , TO_DATE(split(csv_row, ',')[5], 'dd MMM yyyy') AS Connected_On
FROM csv_rows
WHERE split(csv_row, ',')[0] <> 'First Name' -- exclude header rows
