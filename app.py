import falcon
from route.something import SomeThingResource

api = falcon.API()
api.add_route('/something', SomeThingResource() )
