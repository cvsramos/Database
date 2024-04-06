import streamlit as st

def show_splash_page():
    st.title("Welcome to HomeNS")
    
    # If you have a logo or relevant picture, uncomment and add the path below
    # st.image('path_to_image', use_column_width=True)
    
    st.header("Your community support portal")
    st.markdown("""
        HomeNS is your hub for connecting with community resources, support systems, and assistance programs.
        Whether you're seeking help or offering it, HomeNS is here to facilitate a better tomorrow for everyone.
        
        **Please use the navigation bar on the left to explore the options available.**
    """)

    st.markdown("---")  # Adding a horizontal line to separate content
    
    st.subheader("About HomeNS")
    st.markdown("""
        HomeNS aims to provide a comprehensive and accessible platform for those in need. Our database
        includes information on local resources, health care services, and support programs. By facilitating
        easier access to this information, we strive to make a positive impact in our community.
        
        For any assistance or queries:
        - Email: fake@email.com
        - Phone: +1 (902) NOT-THIS
    """)
