import os
from dataclasses import dataclass


@dataclass
class Settings:
    dynamo_db_table: str = os.environ.get('DynamoDBTable')
    s3_bucket_name: str = os.environ.get('S3BucketName')
