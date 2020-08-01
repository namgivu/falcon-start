def test(client):
    r = client.simulate_get('/grepapilog/0700')
    assert r.status_code == 200
    log = r.json
    assert isinstance(log, list)
