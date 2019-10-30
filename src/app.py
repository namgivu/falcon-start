import falcon

from src.route.something import SomeThingResource

from src.route.gc_intern_1910.health     import GCIntern1910Resource_health, GCIntern1910Resource_json_health
from src.route.gc_intern_1910.hi         import GCIntern1910Resource_hi, GCIntern1910Resource_json_hi
from src.route.gc_intern_1910.hello_hola import GCIntern1910Resource_hello, GCIntern1910Resource_hola, GCIntern1910Resource_json_hello_hola


api = falcon.API()

#region routing 00 - no json
api.add_route('/something', SomeThingResource() )

api.add_route('/health',       GCIntern1910Resource_health() )

api.add_route('/hi',           GCIntern1910Resource_hi() )
api.add_route('/hello/{name}', GCIntern1910Resource_hello() )  # note cannot call this endpoint with empty :name

# similar to /hello but allow calling endpoint with empty :name
api.add_route('/hola',         GCIntern1910Resource_hola() )
api.add_route('/hola/{name}',  GCIntern1910Resource_hola() )

#endregion


#region routing 01 - with json
api.add_route('/json_health',  GCIntern1910Resource_json_health() )

api.add_route('/json_hi',  GCIntern1910Resource_json_hi() )

api.add_route('/json_hello',             GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hello/{name}',      GCIntern1910Resource_json_hello_hola() )

api.add_route('/json_hola',              GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hola/{name}',       GCIntern1910Resource_json_hello_hola() )

api.add_route('/json_hello_hola',        GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hello_hola/{name}', GCIntern1910Resource_json_hello_hola() )
#endregion
