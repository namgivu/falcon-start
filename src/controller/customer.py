import json
import falcon

from src.model.customer import Customer


class CustomerResource(object):

    def on_get(self, req, resp, id=None):
        r = Customer.get(id) if id else Customer.get_all()  # r aka result

        # make json response from :r
        d = r.to_dict()               if id else \
            [i.to_dict() for i in r]  # i aka item, d aka data_dict

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps(d)
