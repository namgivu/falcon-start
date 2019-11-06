import falcon

from src.controller.something import SomeThingResource

from src.controller.gc_intern_1910.health     import GCIntern1910Resource_health, GCIntern1910Resource_json_health
from src.controller.gc_intern_1910.hi         import GCIntern1910Resource_hi, GCIntern1910Resource_json_hi
from src.controller.gc_intern_1910.hello_hola import GCIntern1910Resource_hello, GCIntern1910Resource_hola, GCIntern1910Resource_json_hello_hola

from src.controller.gc_intern_1910.fullname import GCIntern1910Resource_fullname, GCIntern1910Resource_fullname_via_json_input


api = falcon.API()

#region routing 00 - output as string ie no json
api.add_route('/something', SomeThingResource() )

api.add_route('/health',       GCIntern1910Resource_health() )

api.add_route('/hi',           GCIntern1910Resource_hi() )
api.add_route('/hello/{name}', GCIntern1910Resource_hello() )  # note cannot call this endpoint with empty :name

# similar to /hello but allow calling endpoint with empty :name
api.add_route('/hola',         GCIntern1910Resource_hola() )
api.add_route('/hola/{name}',  GCIntern1910Resource_hola() )

#endregion


#region routing 01 - output as json
api.add_route('/json_health', GCIntern1910Resource_json_health() )

api.add_route('/json_hi', GCIntern1910Resource_json_hi() )

api.add_route('/json_hello',             GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hello/{name}',      GCIntern1910Resource_json_hello_hola() )

api.add_route('/json_hola',              GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hola/{name}',       GCIntern1910Resource_json_hello_hola() )

api.add_route('/json_hello_hola',        GCIntern1910Resource_json_hello_hola() )
api.add_route('/json_hello_hola/{name}', GCIntern1910Resource_json_hello_hola() )
#endregion


#region routing 02 - multiple params
api.add_route('/fullname/{first_name}/{last_name}', GCIntern1910Resource_fullname() )
api.add_route('/fullname_via_json_input',           GCIntern1910Resource_fullname_via_json_input() )
#endregion
