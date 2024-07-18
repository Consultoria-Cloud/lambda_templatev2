import json
from extra_utils import get_lambda_mensagge

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda! - Version Lambda 1.1.0')
    }

if __name__ == "__name__":
    print(lambda_handler({}, {}))