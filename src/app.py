import json
import os

from html2pdf.converter import convert

"""
class LambdaHandler

- get_keys(event) -> list[dict[str, str]]
- get_item(item_key) -> html, save_path
- generate_pdf(html) -> file
- save_file(file, save_path)
- delete_item(item_key)
- handle_event(event) -> None
	- get_keys
	- for each key
		- get_item
		- generate_pdf
		- save_file
		- delete_item
"""

def lambda_handler(event, context):
    """Sample pure Lambda function

    Parameters
    ----------
    event: dict, required
        API Gateway Lambda Proxy Input Format

        Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

    context: object, required
        Lambda Context runtime methods and attributes

        Context doc: https://docs.aws.amazon.com/lambda/latest/dg/python-context-object.html

    Returns
    ------
    Whatever you want to return to the cloudwatch log

    """

    path = os.path.abspath('test2.html')
    convert(f'file:///{path}', 'sample.pdf', print_options={})

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "hello world",
            }
        ),
    }

