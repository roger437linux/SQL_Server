✅ 1. Inicialização

uv init streamlit-00

cd streamlit-00

uv add streamlit pandas sqlalchemy pyodbc



✅ 2. Arquivo de configuração do database

src\streamlit_00\db.py


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
 


✅ 3. Arquivo de configuração misc


.streamlit\config.toml

[theme]
base = "dark"
primaryColor = "#FF4B4B"
backgroundColor = "#0E1117"
secondaryBackgroundColor = "#262730"
textColor = "#FAFAFA"
font = "sans serif"

[client]
toolbarMode = "minimal"

[server]
runOnSave = true
# port = 8502
port = 7777



✅ 4. Arquivo de configuração dados sensíveis


.streamlit\secrets.toml

[database]
server = "127.0.0.1"
database = "hamburgueria"
username = "dev"
password = "xxxxxxxxxx"
driver = "ODBC Driver 18 for SQL Server"


✅ 5. Executar app Python/Streamlit

uv run streamlit run app.py



✅ 6. .gitignore


# Python-generated files
__pycache__/
*.py[oc]
build/
dist/
wheels/
*.egg-info

# Virtual environments
.venv/

# Arquivos de credenciais/dados sensíveis
**/secrets.toml
**/.env

# Garantir que o .gitignore da raiz seja versionado
!/.gitignore


