from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Integer, Text, Column, Date, DateTime

from src.service.postgres import session


Base = declarative_base()
class Customer(Base):
    __tablename__ = 'customers'

    id          = Column(Integer, primary_key=True, autoincrement=True)
    name        = Column(Text)
    dob         = Column(Date)
    updated_at  = Column(DateTime)


    @staticmethod
    def get(id):
        r = session.query(Customer).filter(Customer.id == id).first()
        return r

    @staticmethod
    def get_all():
        r = session.query(Customer).all()
        return r


    def __str__(self): return self.to_dict()
    def __repr__(self): return self.to_dict()

    def to_dict(self):
        return {
            'id'  : self.id,
            'name': self.name,
            'dob' : self.dob.strftime('%Y-%m-%d'),
        }
