WITH raw_msg_data AS
(
    SELECT
          _c0               AS Raw_Message_Data
        , input_file_name() AS email_filename
    FROM binaryFile.`s3://propensity-to-buy/data/linkedin_contacts/raw/msg/*.msg`
)
SELECT
      parse_email_sender(Raw_Message_Data)
      AS Sender_Name
    , parse_email_send_date(Raw_Message_Data)
      AS Send_Date
    -- , extract_file_from_zip(get_email_attachment(Raw_Message_Data, "*.zip", 0), "connections.csv")
    --   AS Connections_CSV_File
    , email_filename AS Email_Filename
FROM raw_msg_data
