import falcon
import json


class GCIntern1910Resource_hello():

    def on_get(self, req, resp, name):
        resp.status = falcon.HTTP_200
        resp.body   = f'Hello {name}'


class GCIntern1910Resource_hola():

    def on_get(self, req, resp, name=None):
        if not name: raise falcon.HTTPBadRequest('Param :name is required')  # raise exception with falcon ref. https://falcon.readthedocs.io/en/stable/api/errors.html#error-handling

        resp.status = falcon.HTTP_200
        resp.body   = f'Hola {name}'


class GCIntern1910Resource_json_hello_hola():

    def on_get(self, req, resp, name=None):
        if not name: raise falcon.HTTPBadRequest('Param :name is required')  # raise exception with falcon ref. https://falcon.readthedocs.io/en/stable/api/errors.html#error-handling

        r = {  # r aka result
            'name': f'{name}'
        }

        resp.status = falcon.HTTP_200
        resp.body   = json.dumps(r)
