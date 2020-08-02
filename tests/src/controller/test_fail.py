import pytest
from falcon import testing

from src.app import api


@pytest.fixture()
def client(): return testing.TestClient(api)

def test(client):
    r = client.simulate_get('/fail')
    assert r.status_code != 200
    EXP = {
        'request'    : "<Request: GET 'http://falconframework.org/fail'>",
        'exception'  : "ERROR:division by zero - TYPE:<class 'ZeroDivisionError'>",
        'stacktrace' : 'Traceback (most recent call last):\n  File "/home/namgivu/NN/code/_NN_/l/python/falcon-start2/.venv/lib/python3.8/site-packages/falcon/api.py", line 269, in __call__\n    responder(req, resp, **params)\n  File "/home/namgivu/NN/code/_NN_/_label_/restful/falcon-start2/src/controller/fail.py", line 8, in on_get\n    _ = 1/0  # divide by 0 on purpose to fail\nZeroDivisionError: division by zero\n'
    }
    assert r.json  == EXP
