from falcon import testing
from src.app import api

def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


class Test(testing.TestCase):

    app = api

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now


    def test(self):
        INPUT_name = 'Some Name'
        r = self.simulate_get(f'/hello/{INPUT_name}')
        assert r.status_code == 200
        assert r.text == f'Hello {INPUT_name}'

    # NOTE for empty :name param, we study it via /hola
