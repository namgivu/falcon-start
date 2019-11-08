import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


# load db connection         field                 default value
#                            -------               --------------
v=os.environ.get('DB_USER'); DB_USER = v if v else 'postgres'
v=os.environ.get('DB_PASS'); DB_PASS = v if v else 'postgres'
v=os.environ.get('DB_HOST'); DB_HOST = v if v else ''
v=os.environ.get('DB_PORT'); DB_PORT = v if v else ''
v=os.environ.get('DB_NAME'); DB_NAME = v if v else 'nn_falcon_start'

conn    = f'postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
engine  = create_engine(conn)
Session = sessionmaker(bind=engine)
session = Session()  #TODO ensure that by this line, we only open ONE connection per api instance
