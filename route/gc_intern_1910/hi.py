import falcon
import util

class GCIntern1910Resource_hi():

    def on_get(self, req, resp):
        now = util.get_now()

        if    now.hour <= 12: r = 'Good morning'
        elif  now.hour <= 18: r = 'Good afternoon'
        else:                 r = 'Good evening'

        resp.status = falcon.HTTP_200
        resp.body   = r
