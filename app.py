import streamlit as st
from splash_page import show_splash_page
from search_page import show_report_page, set_db_connection as set_search_db_connection
from insert_form import show_insert_form, set_db_connection as set_insert_db_connection
import psycopg2

def create_connection():
    return psycopg2.connect(
        database="Capstone",
        user="postgres",
        password="student2024",
        host="127.0.0.1",
        port="5432",
    )

def main():
    # Establish database connection
    connection = create_connection()
    
    # Pass the connection to other modules/pages
    set_search_db_connection(connection)
    set_insert_db_connection(connection)
    
    # Sidebar for navigation
    st.sidebar.title("Navigation")
    page_selection = st.sidebar.radio("Go to", ('Home', 'Reports', 'Insert Data'), index=0)

    # Render the selected page based on navigation
    if page_selection == 'Home':
        show_splash_page()
    elif page_selection == 'Reports':
        show_report_page()
    elif page_selection == 'Insert Data':
        show_insert_form()

if __name__ == "__main__":
    main()
