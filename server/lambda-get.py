import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('BUCKET_NAME')

def lambda_handler(event, context):
    
        # Scan the DynamoDB table to retrieve all items
        response = table.scan()

        # Extract the messages from the response
        messages = response['Items']

        # Return the messages as the response
        return {
            'statusCode': 200,
            'headers': {
            'Access-Control-Allow-Origin': '*',  # Allow requests from any origin
            'Access-Control-Allow-Methods': 'GET,OPTIONS',  # Allow GET and OPTIONS methods
            'Access-Control-Allow-Headers': 'Content-Type'  # Allow Content-Type header
        },
            'body': json.dumps({'messages': messages})
        }
   
