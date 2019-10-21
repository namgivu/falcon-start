import falcon


class GCIntern1910Resource_hi():

    def on_get(self, req, resp):
        from src.util import get_now; now = get_now()  #CAUTION: must locally import this way to have mocking working at tests.route.gc_intern_1910.test_hi.Test.test_morning()

        if    now.hour <= 12: r = 'Good morning'
        elif  now.hour <= 18: r = 'Good afternoon'
        else:                 r = 'Good evening'

        resp.status = falcon.HTTP_200
        resp.body   = r
