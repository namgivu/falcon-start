import json
import falcon

from src.model.customer import Customer
from src.service.postgres import session


class CustomerResource(object):

    def on_get(self, req, resp, id=None):
        r = Customer.get(id) if id else Customer.get_all()  # r aka result

        # make json response from :r
        d = r.to_dict()               if id else \
            [i.to_dict() for i in r]  # i aka item, d aka data_dict

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps(d)

    def on_post(self, req, resp):
        body = req.media  # json body containing the :customer to create

        c = Customer()
        c.id   = body.get('id')
        c.name = body.get('name')
        c.dob  = body.get('dob')

        assert c.name
        assert c.dob

        session.add(c)
        session.commit()

        session.flush(c)  # refresh c to get c.id
        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps({'id': c.id})

    def on_put(self, req, resp, id):
        c = Customer.get(id)  # c aka customer
        if not c: raise falcon.HTTPBadRequest(f'Customer not found id={id}')

        body = req.media  # json body containing the fields to update
        name = body.get('name')
        dob  = body.get('dob')

        if name: c.name = name
        if dob:  c.dob  = dob

        session.add(c)
        session.commit()

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps(c.to_dict())
