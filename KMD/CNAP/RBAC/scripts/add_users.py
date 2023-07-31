import argparse
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument("-k", "--api-key", dest='api_key_value')
# parser.add_argument("-a", "--kibana-address", dest='kibana_address')

args = parser.parse_args()

api_key_value = args.api_key_value
# kibana_address = args.kibana_address
kibana_address = "https://kibana-eck.apps.dev.kmdstratus.com"
method = "get"
formula = "api/data_views/data_view"
object_name = "logs-*"


class Request:
    def __init__(self, method, formula, object_name):
        self.method = method.upper()
        self.formula = formula
        self.object_name = object_name
        self.api_key = api_key_value
        self.kibana_address = kibana_address

    def __str__(self):
        return f"""curl -X {self.method} -k {self.kibana_address}/{self.formula}/{self.object_name} \
        --header 'Content-Type: application/json;charset=UTF-8' \
        --header 'kbn-xsrf: true' \
        --header 'Authorization: ApiKey {self.api_key}'"""


test = Request(method, formula, object_name)
aaaaa = str(test)
# result = subprocess.call(str(test).split())
# print(result)
# subprocess.call(['curl', '-X', 'GET', '-k', 'https://kibana-eck.apps.dev.kmdstratus.com/api/data_views/data_view/logs-*', '--header', "'Content-Type:", "application/json;charset=UTF-8'", '--header', "'kbn-xsrf:", "true'", '--header', "'Authorization:", 'ApiKey', "bE9PakRvUUJkeHZNVk9XWGJib1M6RVdzZHlZR1pRLVNFSHFybVp2OXV0Zw=='"])
