from request.get_parking_vacancy_api import get_parking_vacancy_api


def handler(event, context):
    print(f"event = {event}")
    print(f"context = {context}")

    response = {
        "message": "get_parking_vacancy_api"
    }

    params = {
        "data": "info"
    }

    query_param = event.get("queryStringParameters")
    if query_param:
        lang = query_param.get("lang") or "zh_TW"
        if lang:
            params["lang"] = lang

    data = get_parking_vacancy_api(params)

    response = {
        "message": "get_parking_vacancy_api",
        "result": data or []
    }

    return response
