```bash
: after docker-compose up
docker exec nn_falcon_start_postgres bash -c 'mkdir -p /falcon_start/bin/db/'

: namgivu@local:/path/to/falcon-start
cp .env-sample .env
: edit .env to match params with your local
docker cp .en                nn_falcon_start_postgres:/falcon_start/.env
docker cp bin/db/reset_db.sh nn_falcon_start_postgres:/falcon_start/bin/db/
docker cp bin/db/seed_db.sql nn_falcon_start_postgres:/falcon_start/bin/db/

```
