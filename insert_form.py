import streamlit as st

db_connection = None

def set_db_connection(connection):
    global db_connection
    db_connection = connection

def fetch_necessities():
    query = "SELECT necessity_id, necessity_title FROM public.necessities;"
    with db_connection.cursor() as cur:
        cur.execute(query)
        # We need to fetch both the id and the title to use it in the selectbox
        result = cur.fetchall()
    return result

# Assuming db_connection is a global variable set in app.py and passed here via set_db_connection.
def insert_person(first_name, last_name, email, homeless_reason, necessity_id):
    query = """
    INSERT INTO public.person (first_name, last_name, email, homeless_reason)
    VALUES (%s, %s, %s, %s) RETURNING person_id;
    """
    with db_connection.cursor() as cur:
        cur.execute(query, (first_name, last_name, email, homeless_reason))
        person_id = cur.fetchone()[0]  # Fetch the generated person_id
        
        if necessity_id:  # If a necessity is selected, relate it to the person
            necessity_query = """
            INSERT INTO public.person_necessities (person_id, necessity_id) VALUES (%s, %s);
            """
            cur.execute(necessity_query, (person_id, necessity_id))
        
        db_connection.commit()
    st.success("Person added successfully with ID: {}".format(person_id))

def show_insert_form():
    necessities_options = fetch_necessities()  # Fetch the dynamic options for the dropdown

    with st.form("new_person_form"):
        first_name = st.text_input("First Name")
        last_name = st.text_input("Last Name")
        email = st.text_input("Email")
        homeless_reason = st.text_area("Homeless Reason")
        
        # Use the fetched necessities options for the dropdown
        necessity_choice = st.selectbox("Necessity", options=[(0, 'None')] + necessities_options, format_func=lambda x: x[1])
        
        submitted = st.form_submit_button("Submit")
        if submitted:
            # Pass the selected necessity_id to the insert function
            insert_person(first_name, last_name, email, homeless_reason, necessity_choice[0] if necessity_choice[0] != 0 else None)


# Remember to define and use the set_db_connection function to pass the connection from app.py to this module.
