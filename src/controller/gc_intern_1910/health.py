import falcon
import json


class GCIntern1910Resource_health():

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200


class GCIntern1910Resource_json_health():

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.body   = json.dumps({})
