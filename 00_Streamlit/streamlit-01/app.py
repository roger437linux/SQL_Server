import streamlit as st
from src.streamlit_01.db import consultar

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

    #    Exercício 1
    #            
    q1 = '''
        SELECT * FROM clientes
        WHERE bairro = 'Centro'
        ORDER BY nome ASC;
    '''

    if st.button("Query 1"):
        st.write('A Dona Marta quer saber quantos clientes cadastrados moram no bairro Centro.')
        st.dataframe(consultar(q1), width="stretch", hide_index=True)


    #    Exercício 2
    #        
    q2 = '''
        SELECT nome_produto, preco FROM produtos
        WHERE categoria LIKE '%_amb_rguer%' AND preco > 30
        ORDER BY preco DESC;
    '''

    if st.button("Query 2"):
        st.write('Liste o nome e o preço dos produtos da categoria Hambúrguer que custam \
                 mais de R$ 30,00, do mais caro para o mais barato.')
        st.dataframe(consultar(q2), width="stretch", hide_index=True)



# ------------------------

if __name__ == "__main__":
    conexao()
