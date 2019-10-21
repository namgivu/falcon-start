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
        r = self.simulate_get(f'/hola/{INPUT_name}')
        assert r.status_code == 200
        assert r.text == f'Hola {INPUT_name}'


    def test_empty(self):
        INPUT_name = ''
        r = self.simulate_get(f'/hola/{INPUT_name}')
        assert r.status_code != 200
        e=r.json.get('title'); assert e  # e aka exception
        assert 'Param :name is required' in e
