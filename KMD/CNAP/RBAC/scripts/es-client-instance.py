from elasticsearch import Elasticsearch
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--api-key-id", dest='api_key_id')
parser.add_argument("-k", "--api-key-value", dest='api_key_value')
parser.add_argument("-h", "--host-url", dest='host_url')

args = parser.parse_args()

api_key_id = args.api_key_id
api_key_value = args.api_key_value
host_url = args.api_key_url

es = Elasticsearch(
    host_url,
    api_key=(api_key_id, api_key_value),
    # connection_class=RequestsHttpConnection,
    # use_ssl=True,
    verify_certs=False
)
