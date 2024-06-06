import json
from request.get_parking_vacancy_api import get_parking_vacancy_api


def handler(event, context):
    print(f"event = {event}")
    print(f"context = {context}")

    response = {
        'statusCode': 200,
        'headers': {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": True
        },
        'body': json.dumps({
            "message": "get_parking_vacancy_api"
        })
    }

    if event:
        query_param = event.get("queryStringParameters")
        if query_param:
            params = {
                "data": "info"
            }

            lang = query_param.get("lang") or "zh_TW"
            if lang:
                params["lang"] = lang

            data = get_parking_vacancy_api(params)

            response = {
                'statusCode': 200,
                'headers': {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Credentials": True
                },
                'body': json.dumps({
                    "message": "get_parking_vacancy_api",
                    "result": data or []
                })
            }

    return response
