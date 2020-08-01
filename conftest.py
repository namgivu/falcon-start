import pytest
from falcon import testing

from src.app import api


@pytest.fixture()
def client(): return testing.TestClient(api)


def pytest_configure(config):
    """hook if needed when pytest start"""
    pass


def pytest_unconfigure(config):
    """hook if needed when pytest end"""
    pass
