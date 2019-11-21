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
    , raw.filename                          AS filepath
    , reverse(split(raw.filename, '/'))[0]  AS filename
FROM linkedin_contacts_raw raw
