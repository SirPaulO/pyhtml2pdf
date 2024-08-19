import json
import os
from typing import Any

from html2pdf.converter import convert

"""
class LambdaHandler

- get_keys(event) -> list[dict[str, str]]
- get_item(item_key) -> html, save_path
- save_tmp_file(file) -> tmp_file_path
- generate_pdf(tmp_file_path) -> file
- save_file(file, save_path) -> None
- delete_item(item_key) -> None
- handle_event(event) -> None
	- get_keys
	- for each key
		- get_item
		- generate_pdf
		- save_file
		- delete_item
"""

def lambda_handler(event: dict, context: Any) -> dict:
    """Lambda function handler

    Args:
        event: dict event
        context: Lambda Context runtime methods and attributes. Doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html
    Returns: dict for logging
    """

    path = os.path.abspath('test.html')
    convert(f'file:///{path}', 'sample.pdf', print_options={})

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "hello world",
            }
        ),
    }

