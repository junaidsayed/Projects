# Save this in C:\Users\ASUS\Desktop\projects\DATA SCIENCE Sentiment Analysis\app.py
import streamlit as st
import joblib
import pandas as pd

# Load the saved model
model = joblib.load('sentiment_model.pkl')

st.set_page_config(page_title="📱 Mobile Review Sentiment Analyzer")

st.title("📊 Sentiment Analysis for Mobile Reviews")
st.write("Enter a mobile review to predict the sentiment.")

user_title = st.text_input("Review Title", "")
user_review = st.text_area("Review Body", "")

if st.button("Analyze Sentiment"):
    if user_review.strip() == "":
        st.warning("❗ Please enter the review body to proceed.")
    else:
        input_df = pd.DataFrame({
            'cleaned_body': [user_review.lower()],
            'review_length': [len(user_review.split())],
            'title_length': [len(user_title.split())],
            'brand': ['samsung' if 'samsung' in user_review.lower()
                      else 'iphone' if 'iphone' in user_review.lower()
                      else 'realme' if 'realme' in user_review.lower()
                      else 'vivo' if 'vivo' in user_review.lower()
                      else 'oppo' if 'oppo' in user_review.lower()
                      else 'other']
        })

        prediction = model.predict(input_df)[0]
        st.success(f"🧾 **Predicted Sentiment:** {prediction}")
