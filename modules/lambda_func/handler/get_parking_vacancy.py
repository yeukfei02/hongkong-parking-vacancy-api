import json
from request.get_parking_vacancy_api import get_parking_vacancy_api


def handler(event, context):
    print(f"event = {event}")
    print(f"context = {context}")

    params = {
        "data": "info",
        "lang": "zh_TW"
    }

    if event:
        data = event.get("data")
        if data:
            params["data"] = data

        vehicle_types = event.get("vehicle_types")
        if vehicle_types:
            params["vehicle_types"] = vehicle_types

        carpark_ids = event.get("carpark_ids")
        if carpark_ids:
            params["carpark_ids"] = carpark_ids

        lang = event.get("lang")
        if lang:
            params["lang"] = lang

    parking_vacancy_result = get_parking_vacancy_api(params)

    response = {
        "message": "get_parking_vacancy_api",
        "result": parking_vacancy_result or []
    }

    return response
