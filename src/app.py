import falcon

api = falcon.API()


class HelloResource:

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.body   = 'Hello122333'

class HiResource:

    def on_get(self, req, resp, name):
        resp.status = falcon.HTTP_200
        resp.body   = f'Hi {name}!'

api.add_route('/hello', HelloResource())
api.add_route('/hi/{name}', HiResource())
