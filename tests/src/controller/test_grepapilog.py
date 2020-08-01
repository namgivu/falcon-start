import json
from textwrap import dedent

from src.util import LOG_FILE


def test(client):
    #region make apilog fixture
    with open(LOG_FILE, 'w') as f:
        f.write(dedent('''
              do_handshake_on_connect: False
              ciphers: None
              raw_paste_global_conf: []
              strip_header_spaces: False
            [2020-08-01 11:33:38 +0000] [6] [INFO] Starting gunicorn 20.0.4
            [2020-08-01 11:33:38 +0000] [6] [DEBUG] Arbiter booted
            [2020-08-01 11:33:38 +0000] [6] [INFO] Listening at: http://0.0.0.0:5000 (6)
            [2020-08-01 11:33:38 +0000] [6] [INFO] Using worker: sync
            [2020-08-01 11:33:38 +0000] [15] [INFO] Booting worker with pid: 15
            [2020-08-01 11:33:38 +0000] [6] [DEBUG] 1 workers
            [2020-08-01 11:33:42 +0000] [15] [DEBUG] GET /health
            [2020-08-01 11:33:42 +0000] [15] [ERROR] Error handling request /health
            Traceback (most recent call last):
              File "/app/.venv/lib/python3.8/site-packages/gunicorn/workers/sync.py", line 134, in handle
                self.handle_request(listener, req, client, addr)
              File "/app/.venv/lib/python3.8/site-packages/gunicorn/workers/sync.py", line 175, in handle_request
                respiter = self.wsgi(environ, resp.start_response)
              File "/app/.venv/lib/python3.8/site-packages/falcon/api.py", line 269, in __call__
                responder(req, resp, **params)
              File "/app/src/controller/health.py", line 10, in on_get
                i = 1/0
            ZeroDivisionError: division by zero
        ''').strip())
    #endregion make apilog fixture

    grep_regex=''; r=client.simulate_get('/grepapilog', body=json.dumps({'grep -E': grep_regex})); assert r.status_code==200; log=r.text
    assert 'Starting gunicorn'                 in log
    assert 'Listening at: http://0.0.0.0:5000' in log

    grep_regex='GET /health' ; r=client.simulate_get('/grepapilog', body=json.dumps({'grep -E': grep_regex})); assert r.status_code==200; log=r.text
    assert '[2020-08-01 11:33:42 +0000] [15] [DEBUG] GET /health' in log

    grep_regex='2020-08-01 11:33:42' ; r=client.simulate_get('/grepapilog', body=json.dumps({'grep -E': grep_regex})); assert r.status_code==200; log=r.text
    EXP = dedent('''
        [2020-08-01 11:33:42 +0000] [15] [DEBUG] GET /health
        [2020-08-01 11:33:42 +0000] [15] [ERROR] Error handling request /health
    ''')
    assert log.strip() == EXP.strip()
