import falcon
import json
import subprocess

from src.util import LOG_FILE


class GrepApiLog:

    def on_get(self, req, resp):
        grep_regex = req.media.get('grep -E', '')  #  the shell-alike grep regex
        #region run shell's grep ref. https://stackoverflow.com/a/20004896/248616
        cmd = ['/bin/grep', '-E', grep_regex, LOG_FILE]
        spr_r = subprocess.run(cmd, stdout=subprocess.PIPE) ; r=spr_r.stdout.decode('utf-8')  # spr_r aka subprocess.run_result
        #       .          .   .    .                         binary to string
        #endregion

        #region grep :apilog into :log
        log = r.split('\n')
        #endregion

        resp.body = json.dumps(log)
