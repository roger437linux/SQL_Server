import streamlit as st
import plotly.express as px
from src.streamlit_sql.db import consultar

st.title("🍔 Database Hamburgueria")

def conexao():
    try:
        query = consultar('SELECT UPPER(@@SERVERNAME)')

        st.dataframe(query, width="stretch", hide_index=True)
        st.success("✅ Conexão realizada com sucesso!")
        queries()

    except Exception as e:
        st.error("❌ Erro ao conectar ao banco de dados.")
        st.exception(e)


def queries():

    #####################
    #    Exercício 1    
    #####################
        
    q1 = '''
        SELECT TOP(5) * FROM produtos
    '''

    if st.button("Query 1"):
        st.dataframe(consultar(q1), width="stretch", hide_index=True)


    #####################
    #    Exercício 2    
    #####################
        
    q2 = '''
        SELECT TOP(5) * FROM clientes
    '''

    if st.button("Query 2"):
        st.dataframe(consultar(q2), width="stretch", hide_index=True)


# ------------------------

if __name__ == "__main__":
    conexao()
