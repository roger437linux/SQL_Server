import streamlit as st
import pandas as pd
import re

from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

SERVIDOR = 'D08S22-1251878\SQLEXPRESSTUX'
BANCO = 'hamburgueria'
DRIVER = 'ODBC Driver 18 for SQL Server'

def conectar():
    # Autenticação pelo Windows usando ODBC
    
    odbc = (
        f"DRIVER={{{DRIVER}}};SERVER={SERVIDOR};DATABASE={BANCO};"
        "Trusted_Connection=yes;TrustServerCertificate=yes"
    )

    return create_engine("mssql+pyodbc:///?odbc_connect="+ quote_plus(odbc))

def consultar(sql):
    with conectar().connect() as conexao:
        return pd.read_sql(text(sql), conexao)
