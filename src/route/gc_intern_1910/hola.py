import falcon


class GCIntern1910Resource_hola():

    def on_get(self, req, resp, name=None):
        if not name: raise falcon.HTTPBadRequest('Param :name is required')  # raise exception with falcon ref. https://falcon.readthedocs.io/en/stable/api/errors.html#error-handling

        resp.status = falcon.HTTP_200
        resp.body   = f'Hola {name}'
