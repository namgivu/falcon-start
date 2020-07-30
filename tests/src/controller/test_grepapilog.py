import pytest
from falcon import testing

from src.app import api


#TODO extract into pytest_init to deduplicate code
@pytest.fixture()
def client(): return testing.TestClient(api)


def test(client):
    r = client.simulate_get('/grepapilog/0700')
    assert r.status_code == 200
    log = r.json
    assert isinstance(log, list)
