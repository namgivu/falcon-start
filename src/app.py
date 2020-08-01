import falcon
import json
import traceback

from src.controller.health import Health
from src.controller.fail import Fail


api = falcon.API()

api.add_route('/health', Health() )
