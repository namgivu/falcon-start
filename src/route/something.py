import falcon

class SomeThingResource(object):

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200  # This is the default status
        resp.body = 'This is sample /something response as a string'

        #TODO return value as JSON
        '''
        resp.body = {
            'message': 'This is sample /something response as dict'
        }
        '''
