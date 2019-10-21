import falcon

from src.route.something import SomeThingResource
from src.route.gc_intern_1910.health import GCIntern1910Resource_health
from src.route.gc_intern_1910.hi     import GCIntern1910Resource_hi


api = falcon.API()

#region routing
api.add_route('/something', SomeThingResource() )

api.add_route('/health', GCIntern1910Resource_health() )
api.add_route('/hi',     GCIntern1910Resource_hi() )
#endregion routing
