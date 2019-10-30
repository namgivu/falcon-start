from falcon import testing
from datetime import datetime
from unittest.mock import patch, MagicMock

from src.app import api


def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


MOCKED_morning   = 8
MOCKED_afternoon = 16
MOCKED_evening   = 22

class Test(testing.TestCase):

    def setUp(self):    pass  # nothing here for now
    def tearDown(self): pass  # nothing here for now

    app = api

    @patch('src.util.get_now', MagicMock(return_value=datetime(2000, 11, 22, hour=MOCKED_morning)))  # mock now() to be 8AM  #CAUTION: we cannot mock built-in datetime.datetime.now() here --> must go around via util.get_now()
    def test_morning(self):
        r = self.simulate_get('/json_hi')
        assert r.status_code == 200
        assert r.json == {
            'message': 'Good morning'
        }


    @patch('src.util.get_now', MagicMock(return_value=datetime(2000, 11, 22, hour=MOCKED_afternoon)))  # mock now() to be 8AM  #CAUTION: we cannot mock built-in datetime.datetime.now() here --> must go around via util.get_now()
    def test_afternoon(self):
        r = self.simulate_get('/json_hi')
        assert r.status_code == 200
        assert r.json == {
            'message': 'Good afternoon'
        }


    @patch('src.util.get_now', MagicMock(return_value=datetime(2000, 11, 22, hour=MOCKED_evening)))  # mock now() to be 8AM  #CAUTION: we cannot mock built-in datetime.datetime.now() here --> must go around via util.get_now()
    def test_evening(self):
        r = self.simulate_get('/json_hi')
        assert r.status_code == 200
        assert r.json == {
            'message': 'Good evening'
        }
