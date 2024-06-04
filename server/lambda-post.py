import json
import boto3
import uuid

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('BUCKET_NAME')

def lambda_handler(event, context):
    try:
        # Generate a UUID as the partition key
        id = str(uuid.uuid4())

        # Access data from the event object
        message = event.get('message')

        # Put the item into DynamoDB
        response = table.put_item(
            Item={
                'id': id,  # Use UUID as the partition key
                'message': message
            }
        )

        # Return a success response
        return {
            'statusCode': 200,
            'headers': {
            'Access-Control-Allow-Origin': '*',  # Allow requests from any origin
            'Access-Control-Allow-Methods': 'GET,OPTIONS',  # Allow GET and OPTIONS methods
            'Access-Control-Allow-Headers': 'Content-Type'  # Allow Content-Type header
        },
            'body': json.dumps({'id': id, 'message': message, 'status': 'Message added successfully to DynamoDB'})
        }
    except Exception as e:
        print('Error adding message to DynamoDB:', str(e))
        # Return an error response
        return {
            'statusCode': 500,
            'headers': {
            'Access-Control-Allow-Origin': '*',  # Allow requests from any origin
            'Access-Control-Allow-Methods': 'GET,OPTIONS',  # Allow GET and OPTIONS methods
            'Access-Control-Allow-Headers': 'Content-Type'  # Allow Content-Type header
        },
            'body': json.dumps({'message': 'Error adding message to DynamoDB'})
        }
