import falcon
from falcon_cors import CORS
import json
import traceback

from src.controller.health import Health
from src.controller.fail import Fail
from src.controller.grepapilog import GrepApiLog


middleware = []

#region allow all cors origins+methods ref. https://stackoverflow.com/a/60036107/248616
cors = CORS(
    allow_all_origins=True,
    allow_all_headers=True,
    allow_all_methods=True,
)
middleware.append(cors.middleware)  # ref. https://github.com/lwcolton/falcon-cors#usage
#endregion

api = falcon.API()

api.add_route('/health', Health() )
api.add_route('/fail', Fail() )

api.add_route('/grepapilog', GrepApiLog() )


#region replace_internal_server_5000
def replace_internal_server_5000(ex, req, resp, params):  # ex aka exception, req aka request, resp aka response
    """
    custom exception response ref. https://stackoverflow.com/a/52464930/248616
    CAUTION this will gobble actual HTTPError returned from the application code ref. https://stackoverflow.com/a/60606760/248616
    """

    r = {
        'request'    : str(req),
        'params'     : params if params else None,
        'exception'  : f'ERROR:{str(ex)} - TYPE:{type(ex)}' if str(ex) else None,
        'stacktrace' : traceback.format_exc(),
    }

    # remove empty value
    empty_k = [ k for k,v in r.items() if v is None ]
    for k in empty_k: r.pop(k)

    # conclusion
    resp.status = falcon.HTTP_400
    resp.body   = json.dumps(r)

api.add_error_handler(Exception, handler=replace_internal_server_5000)
#endregion replace_internal_server_5000
