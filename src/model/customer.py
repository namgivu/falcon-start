from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Integer, Text, Column, Date, DateTime

from src.service.postgres import get_session


Base = declarative_base()
class Customer(Base):
    __tablename__ = 'customers'

    id          = Column(Integer, primary_key=True, autoincrement=True)
    name        = Column(Text)
    dob         = Column(Date)
    updated_at  = Column(DateTime)


    @staticmethod
    def get(id):
        session = get_session()
        r = session.query(Customer).filter(Customer.id == id).first()
        session.close()
        return r

    @staticmethod
    def get_all():
        session = get_session()
        r = session.query(Customer).all()
        session.close()
        return r


    def __str__(self): return self.to_dict()
    def __repr__(self): return self.to_dict()

    def to_dict(self):
        return {
            'id'  : self.id,
            'name': self.name,
            'dob' : self.dob.strftime('%Y-%m-%d'),

            'updated_at' : self.updated_at.strftime('%Y-%m-%d %H:%M:%S') if self.updated_at else '',
        }
