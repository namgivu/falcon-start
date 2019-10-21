import falcon

from src.route.something import SomeThingResource
from src.route.gc_intern_1910.health import GCIntern1910Resource_health
from src.route.gc_intern_1910.hi     import GCIntern1910Resource_hi
from src.route.gc_intern_1910.hello  import GCIntern1910Resource_hello
from src.route.gc_intern_1910.hola   import GCIntern1910Resource_hola


api = falcon.API()

#region routing
api.add_route('/something', SomeThingResource() )

#region gc intern 1910 endpoints
api.add_route('/health',       GCIntern1910Resource_health() )

api.add_route('/hi',           GCIntern1910Resource_hi() )
api.add_route('/hello/{name}', GCIntern1910Resource_hello() )  # note cannot call this endpoint with empty :name

# similar to /hello but allow calling endpoint with empty :name
api.add_route('/hola',         GCIntern1910Resource_hola() )
api.add_route('/hola/{name}',  GCIntern1910Resource_hola() )
#endregion

#endregion routing
