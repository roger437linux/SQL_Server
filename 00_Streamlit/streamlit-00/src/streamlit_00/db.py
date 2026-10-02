import streamlit as st
import pandas as pd

from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

servidor    =   st.secrets["database"]["server"]
banco       =   st.secrets["database"]["database"]
usuario     =   st.secrets["database"]["username"]
senha       =   st.secrets["database"]["password"]
driver      =   st.secrets["database"]["driver"]

def conectar():

    odbc = (
        f"DRIVER={{{driver}}};"
        f"SERVER={servidor};"
        f"DATABASE={banco};"
        f"UID={usuario};"
        f"PWD={senha};"
        "TrustServerCertificate=yes;"
    )

    return create_engine(
        "mssql+pyodbc:///?odbc_connect=" + quote_plus(odbc)
    )


def consultar(sql):
    with conectar().connect() as conexao:
        return pd.read_sql(text(sql), conexao)
 