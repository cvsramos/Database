import streamlit as st
import psycopg2
from psycopg2 import OperationalError
import pandas as pd

db_connection = None

def set_db_connection(connection):
    global db_connection
    db_connection = connection

# Query execution function
def run_query(query):
    global db_connection  # Make sure to declare it as global if you're going to use it in this way
    with db_connection.cursor() as cur:
        cur.execute(query)
        result = cur.fetchall()
        columns = [desc[0] for desc in cur.description]
    # No need to close the connection here
    return pd.DataFrame(result, columns=columns)

# Function to show data
def show_data(query):
    df = run_query(query)
    st.write(df)

# Report page function
def show_report_page():
    st.title("HomeNS Database Reports")

    st.header("Reports")
    st.markdown("Select a report from the options below to view the latest statistics and data.")

    # Most frequent disease report
    if st.button('Show Most Frequent Disease'):
        most_frequent_disease_query = """
        SELECT disease_title, COUNT(*) as frequency
        FROM public.disease JOIN public.person_health ON public.disease.disease_id = public.person_health.disease_id
        GROUP BY disease_title
        ORDER BY frequency DESC
        LIMIT 1;
        """
        show_data(most_frequent_disease_query)

    # Most frequent homeless reason report
    if st.button('Show Most Frequent Homeless Reason'):
        most_frequent_homeless_reason_query = """
        SELECT homeless_reason, COUNT(*) as frequency
        FROM public.person
        WHERE homeless_reason IS NOT NULL
        GROUP BY homeless_reason
        ORDER BY frequency DESC
        LIMIT 1;
        """
        show_data(most_frequent_homeless_reason_query)

    # Number of organizations listed to help
    if st.button('Show Number of Organizations'):
        number_of_organizations_query = "SELECT COUNT(*) as organization_count FROM public.organization;"
        show_data(number_of_organizations_query)

    # Most frequent necessity
    if st.button('Show Most Frequent Necessity'):
        most_frequent_necessity_query = """
        SELECT necessity_title, COUNT(*) as frequency
        FROM public.necessities JOIN public.person_necessities ON public.necessities.necessity_id = public.person_necessities.necessity_id
        GROUP BY necessity_title
        ORDER BY frequency DESC
        LIMIT 1;
        """
        show_data(most_frequent_necessity_query)