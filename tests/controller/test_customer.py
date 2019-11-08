from src.app import api
from falcon import testing


def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


class Test(testing.TestCase):

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now

    app = api

    def test_get_all(self):
        EXP_r = [  # EXP_r aka expected_result
            {'id': 1, 'name': 'Name01', 'dob': '2018-01-02'},
            {'id': 2, 'name': 'Name02', 'dob': '2018-03-03'},
            {'id': 3, 'name': 'Name03', 'dob': '2018-03-04'},
            {'id': 4, 'name': 'Name04', 'dob': '2018-04-05'},
            {'id': 5, 'name': 'Name05', 'dob': '2018-05-06'},
        ]

        # testee
        r = self.simulate_get('/customers')

        assert r.status_code == 200
        assert r.json == EXP_r

    def test_get_at_id(self):
        EXP_r = {'id': 1, 'name': 'Name01', 'dob': '2018-01-02'}  # EXP_r aka expected_result

        # testee
        r = self.simulate_get('/customers/1')

        assert r.status_code == 200
        assert r.json == EXP_r
