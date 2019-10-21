import falcon


class GCIntern1910Resource_health():

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200

