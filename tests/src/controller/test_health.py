import pytest
from falcon import testing

from src.app import api


@pytest.fixture()
def client(): return testing.TestClient(api)

def test(client):
    r = client.simulate_get('/health')
    assert r.status_code == 200
    assert r.json  == {}
