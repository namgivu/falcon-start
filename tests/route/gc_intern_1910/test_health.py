from src.app import api
from falcon import testing


def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


class Test(testing.TestCase):

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now

    app = api

    def test(self):
        r = self.simulate_get('/health')
        assert r.status_code == 200


    def test2(self):
        r = self.simulate_get('/json_health')
        assert r.status_code == 200
        assert r.json == {}
