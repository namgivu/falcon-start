```bash
: after docker-compose bash been up
docker exec nn_falcon_start_postgres bash -c 'mkdir -p /falcon_start/bin/db/'

: namgivu@local:/path/to/falcon-start
    # prepare scripts
    cp .env-sample .env
    : edit .env to match params with your local

    docker cp bin/docker/.env     nn_falcon_start_postgres:/falcon_start/.env
    docker cp bin/db/reset_db.sh  nn_falcon_start_postgres:/falcon_start/bin/db/
    docker cp bin/db/seed_db.sql  nn_falcon_start_postgres:/falcon_start/bin/db/
    
    # run it
    docker exec nn_falcon_start_postgres bash -c '/falcon_start/bin/db/reset_db.sh'

```
