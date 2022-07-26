class Config(object):
    pass

class ProdConfig(Config):
    pass

class DevConfig(Config):
    DEBUG = True
    '''
    # SQLite connection string/uri is a path to the database file - relative or
    absolute.
    sqlite:///database.db
    # MySQL
    mysql+pymysql://user:password@ip:port/db_name
    # Postgres
    postgresql+psycopg2://user:password@ip:port/db_name
    # MSSQL
    mssql+pyodbc://user:password@dsn_name
    # Oracle
    oracle+cx_oracle://user:password@ip:port/db_name
    '''
    SQLALCHEMY_DATABASE_URI = "sqlite:///database.db"