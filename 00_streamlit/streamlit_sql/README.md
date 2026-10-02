uv init streamlit\_sql
cd streamlit\_sql

uv add streamlit pandas sqlalchemy pyodbc plotly



uv run streamlit run app.py





✅ .streamlit/config.toml



\[theme]

base = "dark"

primaryColor = "#FF4B4B"

backgroundColor = "#0E1117"

secondaryBackgroundColor = "#262730"

textColor = "#FAFAFA"

font = "sans serif"



\[client]

toolbarMode = "minimal"



\[server]

runOnSave = true

\# port = 8502

port = 7777







✅ .streamlit/secrets.toml



\[database]

server = "127.0.0.1"

database = "hamburgueria"

username = "xxxxxx"

password = "xxxxxx"

driver = "ODBC Driver 18 for SQL Server"

