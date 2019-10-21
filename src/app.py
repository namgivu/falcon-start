import falcon

from src.route.something import SomeThingResource
from src.route.gc_intern_1910.health import GCIntern1910Resource_health
from src.route.gc_intern_1910.hi     import GCIntern1910Resource_hi
from src.route.gc_intern_1910.hello  import GCIntern1910Resource_hello


api = falcon.API()

#region routing
api.add_route('/something', SomeThingResource() )

#region gc intern 1910 endpoints
api.add_route('/health', GCIntern1910Resource_health() )
api.add_route('/hi', GCIntern1910Resource_hi() )
api.add_route('/hello/{name}', GCIntern1910Resource_hello() )
#endregion

#endregion routing
