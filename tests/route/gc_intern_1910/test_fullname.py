import json

from src.app import api
from falcon import testing


def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


class Test(testing.TestCase):

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now

    app = api

    def test(self):
        r = self.simulate_get('/fullname/some_fn/some_ln')
        assert r.status_code == 200
        assert r.json == {
            'message': 'some_fn some_ln'
        }


    def test2(self):
        INP = {
            'first_name': 'fn',
            'last_name' : 'ln',
        }
        r = self.simulate_post('/fullname_via_json_input', body=json.dumps(INP))
        assert r.status_code == 200
        assert r.json == {
            'message': 'fn ln'
        }
