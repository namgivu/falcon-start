def test(client):
    r = client.simulate_get('/health')
    assert r.status_code == 200
    assert r.json  == {}
