import falcon as falcon

from src.controller.health import Health
from src.controller.grepapilog import GrepApiLog


api = falcon.API()

api.add_route('/health', Health() )
api.add_route('/grepapilog/{shellgrepalike_regex}', GrepApiLog() )
