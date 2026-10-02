import streamlit as st
from src.streamlit_00.db import consultar

st.title("🍔 Hamburgueria")
st.write("Teste de conexão com SQL Server")

if st.button("Testar conexão"):
    try:

        df = consultar("""
            SELECT
                DB_NAME() AS banco,
                UPPER(@@SERVERNAME) AS servidor,
                UPPER(SUSER_SNAME())
        """)

        st.success("✅ Conexão realizada com sucesso!")

        st.dataframe(
            df,
            width="stretch",
            hide_index=True
        )

    except Exception as e:
        st.error("❌ Erro ao conectar ao banco de dados.")
        st.exception(e)
