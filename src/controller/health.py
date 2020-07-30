import falcon
import json


class Health:

    def on_get(self, req, resp):
        resp.status_code = falcon.HTTP_OK
        resp.body = json.dumps({})
