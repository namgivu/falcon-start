import falcon
import json
import subprocess

from src.util import LOG_FILE


class GrepApiLog:

    def on_get(self, req, resp, shellgrepalike_regex):
        resp.status_code = falcon.HTTP_OK

        #region run shell's grep ref. https://stackoverflow.com/a/20004896/248616
        cmd = ['/bin/grep', '-E', shellgrepalike_regex, LOG_FILE]
        spr_r = subprocess.run(cmd, stdout=subprocess.PIPE) ; r=spr_r.stdout.decode('utf-8')  # spr_r aka subprocess.run_result
        #       .          .   .    .                         binary to string
        #endregion

        #region grep :apilog into :log
        log = r.split('\n')
        #endregion

        resp.body = json.dumps(log)
