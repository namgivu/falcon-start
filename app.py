import falcon

from route.something import SomeThingResource
from route.gc_intern_1910.health import GCIntern1910Resource_health


api = falcon.API()

#region routing
api.add_route('/something', SomeThingResource() )

api.add_route('/health',      GCIntern1910Resource_health() )
#endregion routing
