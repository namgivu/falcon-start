import json
import falcon

from src.model.customer import Customer
from src.service.postgres import get_session


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

        session = get_session()
        session.add(c)
        session.commit()  # this command will fill :id field

        # make result :r with c.id
        r = {'id': c.id}

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps(r)

        session.close()  # .close() go last to dodge ERROR: sqlalchemy.orm.exc.DetachedInstanceError: Instance <Customer at 0x7fb5ea668278> is not bound to a Session; attribute refresh operation cannot proceed (Background on this error at: http://sqlalche.me/e/bhk3)


    def on_put(self, req, resp, id):
        c = Customer.get(id)  # c aka customer
        if not c: raise falcon.HTTPBadRequest(f'Customer not found id={id}')

        body = req.media  # json body containing the fields to update
        name = body.get('name')
        dob  = body.get('dob')

        if name: c.name = name
        if dob:  c.dob  = dob

        session = get_session()
        session.add(c)
        session.commit()

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps(c.to_dict())

        session.close()  # .close() go last to dodge ERROR: sqlalchemy.orm.exc.DetachedInstanceError: Instance <Customer at 0x7fb5ea668278> is not bound to a Session; attribute refresh operation cannot proceed (Background on this error at: http://sqlalche.me/e/bhk3)

    def on_delete(self, req, resp, id):
        c = Customer.get(id)  # c aka customer
        if not c: raise falcon.HTTPBadRequest(f'Customer not found id={id}')

        session = get_session()
        session.delete(c)
        session.commit()
        session.close()

        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = json.dumps({'id': c.id})
