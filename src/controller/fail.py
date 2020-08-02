import falcon
import json


class Fail:

    def on_get(self, req, resp):
        _ = 1/0  # divide by 0 on purpose to fail
