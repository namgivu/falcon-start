import json

from src.app import api, APP_HOME
from falcon import testing

from src.model.customer import Customer
from src.service.postgres import session


def setUpModule():    pass  # nothing here for now
def tearDownModule(): pass  # nothing here for now


def make_fixture():
    seed_db_file = f'{APP_HOME}/../bin/db/seed_db.sql'
    sql = open(seed_db_file, 'r').read()
    session.execute(sql)


class Test(testing.TestCase):

    def setUp(self):
        make_fixture()

    def tearDown(self): pass  # nothing here for now

    app = api

    def test_get_all(self):
        EXP_r = [  # EXP_r aka expected_result
            {'id': 1, 'name': 'Name01', 'dob': '2018-01-02'},
            {'id': 2, 'name': 'Name02', 'dob': '2018-03-03'},
            {'id': 3, 'name': 'Name03', 'dob': '2018-03-04'},
            {'id': 4, 'name': 'Name04', 'dob': '2018-04-05'},
            {'id': 5, 'name': 'Name05', 'dob': '2018-05-06'},
        ]

        # testee
        r = self.simulate_get('/customers')

        assert r.status_code == 200
        assert r.json == EXP_r

    def test_get_at_id(self):
        EXP_r = {'id': 1, 'name': 'Name01', 'dob': '2018-01-02'}  # EXP_r aka expected_result

        # testee
        r = self.simulate_get('/customers/1')

        assert r.status_code == 200
        assert r.json == EXP_r

    def test_post(self):
        INP_customer = {'name': 'NewName', 'dob': '1911-12-23'}  # EXP_r aka expected_result
        EXP_r = {'id': 6}

        # testee
        r = self.simulate_post('/customers', body=json.dumps(INP_customer))

        assert r.status_code == 200
        assert r.json == EXP_r

        # deeper assert for newly added customer
        c = Customer.get(id=EXP_r['id'])  # c aka customer_added
        d = c.to_dict()  # d aka c_as_dict
        d.pop('id')  # no :id when compared
        assert d == INP_customer

    def test_update(self):
        INP_id               = 1
        INP_fields_to_update = {'id':INP_id, 'name': 'UpdateName', 'dob': '1913-12-11'}  # INP_xxx aka INP of xxx

        c_before_update = Customer.get(id=INP_id)

        # testee
        r = self.simulate_put(f'/customers/{INP_id}', body=json.dumps(INP_fields_to_update))

        assert r.status_code == 200

        #region deep assert customer after updated
        c = Customer.get(id=INP_id)
        d = c.to_dict()

        ACTUAL_c = r.json
        assert ACTUAL_c == d != c_before_update
        #endregion

    def test_delete(self):
        INP_id          = 1
        c_before_delete = Customer.get(id=INP_id)

        # testee
        r = self.simulate_delete(f'/customers/{INP_id}')

        assert r.status_code == 200
        assert r.json == {'id': INP_id}

        #region deep assert customer after deleted
        c_after_delete = Customer.get(id=INP_id)
        assert c_before_delete     # before, was existed
        assert not c_after_delete  # after, now been deleted
        #endregion
