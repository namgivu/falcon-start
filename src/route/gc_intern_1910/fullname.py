import falcon
import json


class GCIntern1910Resource_fullname():

    def on_get(self, req, resp, first_name, last_name, ):
        resp.status = falcon.HTTP_200
        resp.body   = json.dumps({
            'message': f'{first_name} {last_name}'
        })


class GCIntern1910Resource_fullname_via_json_input():

    def on_get(self, req, resp):
        params     = req.media
        first_name = params.get('first_name')
        last_name  = params.get('last_name')

        resp.status = falcon.HTTP_200
        resp.body   = json.dumps({
            'message': f'{first_name} {last_name}'
        })
