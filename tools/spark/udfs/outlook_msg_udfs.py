from pyspark.sql.functions import udf
from pyspark.sql import types



"""
Functions to transform and decode Outlook *.msg email files.
"""

# from msg_parser import MsOxMessage
import extract_msg


@udf(types.StructType([
    types.StructField("send_date", types.TimestampType(), False),
    types.StructField("sender_name", types.StringType(), False),
    types.StructField("subject", types.StringType(), False),
    types.StructField("body", types.StringType(), False),
]))
def parse_msg(msg, with_attachments=False, attachment_type="zip"):
    if isinstance(msg, str):
        with open(msg, "rb") as file:
            msg_raw = file.read()
    else:
        msg_raw = msg
    msg_obj = extract_msg.Message(msg_raw)
    # msg_obj = MsOxMessage(filepath)
    # json_string = msg_obj.get_message_as_json()
    msg_properties_dict = {
        "send_date": msg_obj.date,
        "sender_name": msg_obj.sender,
        # "attachment_names": [
        #     attached.longFilename for attached in msg_obj.attachments
        # ],
        "subject": msg_obj.subject,
        "body": msg_obj.body,
    }
    if with_attachments:
        msg_properties_dict["attachments"] = {
            attached.longFilename: attached.data
            for attached in msg_obj.attachments
            if attachment_type is None or attached.longFilename.endswith(attachment_type)
        }
    return [v for v in msg_properties_dict.values()]


@udf(types.BinaryType())
def get_email_attachment(email_file, name_filter, index):
    """
    Returns the Nth attachment that matches the specified name_filter argumnet, where N=index.
    Returns None if not found.
    """
    raise NotImplementedError()
    return None


@udf(types.BinaryType())
def extract_file_from_zip(zipfile, filename):
    """
    Returns the compressed file `filename` from `zipfile`.
    """
    raise NotImplementedError()
    return None


@udf(types.StringType())
def parse_email_sender(email_file):
    """Parse and return the sender name."""
    msg_dict = parse_msg(email_file)
    return msg_dict["sender_name"]


@udf(types.TimestampType())
def parse_email_send_date(email_file):
    """Parse and return the send date."""
    msg_dict = parse_msg(email_file)
    return msg_dict["send_date"]
