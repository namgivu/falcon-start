import falcon as falcon

from src.controller.health import Health

api = falcon.API()

api.add_route('/health', Health() )
