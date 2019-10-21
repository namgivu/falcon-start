import falcon


class GCIntern1910Resource_hello():

    def on_get(self, req, resp, name):
        resp.status = falcon.HTTP_200
        resp.body   = f'Hello {name}'
