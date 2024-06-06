import requests


def get_parking_vacancy_api(params):
    result = None

    try:
        root_url = "https://api.data.gov.hk/v1/carpark-info-vacancy"
        response = requests.get(root_url, params=params)
        print(f"response = {response}")

        if response and response.status_code == 200:
            response_json = response.json()
            print(f"response_json = {response_json}")

            if response_json:
                results_list = response_json.get("results")
                result = results_list
    except Exception as e:
        print(f"get_parking_vacancy_api error = {e}")

    return result
