import falcon
import json
import subprocess

from src.util import LOG_FILE


class GrepApiLog:

    def on_get(self, req, resp, shellgrepalike_regex):
        resp.status_code = falcon.HTTP_OK
        resp.body = json.dumps({})
