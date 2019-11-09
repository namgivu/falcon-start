from falcon import testing
from src.app import api

def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


class Test(testing.TestCase):

    app = api

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now


    #region run-test util

    def _run_empty(self, endpoint):
        r = self.simulate_get(f'/{endpoint}/')
        assert r.status_code != 200
        e=r.json.get('title'); assert e  # e aka exception
        assert 'Param :name is required' in e

        r = self.simulate_get(f'/{endpoint}')
        assert r.status_code != 200
        e=r.json.get('title'); assert e  # e aka exception
        assert 'Param :name is required' in e


    def _run(self, INPUT_name, endpoint):
        r = self.simulate_get(f'/{endpoint}/{INPUT_name}')
        assert r.status_code == 200
        assert r.json == {
            'name': f'{INPUT_name}'
        }

    #endregion util


    def test_empty(self):
        self._run_empty(endpoint='json_hola')
        self._run_empty(endpoint='json_hello')
        self._run_empty(endpoint='json_hello_hola')


    def test(self):
        self._run(INPUT_name='Some Name', endpoint='json_hola')
        self._run(INPUT_name='Some Name', endpoint='json_hello')
        self._run(INPUT_name='Some Name', endpoint='json_hello_hola')
