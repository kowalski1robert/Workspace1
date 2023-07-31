from elasticsearch import Elasticsearch
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-k", "--api-key", dest='api_key_value')

args = parser.parse_args()

api_key_value = args.api_key_value

es = Elasticsearch(
    "https://kibana-eck.apps.dev.kmdstratus.com:443/",
    api_key=("lOOjDoQBdxvMVOWXbboS", api_key_value),
    # connection_class=RequestsHttpConnection,
    # use_ssl=True,
    verify_certs=False
)
es.ping()

# test = es.get(index="logs-*", id="logs-*")
# print(test)
