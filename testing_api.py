import openai
import os

# Set your API key
client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY", "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"))

# Test the chat completion
def test_openai():
    try:
        response = client.chat.completions.create(
            model= "gpt-4o-mini", #"gpt-3.5-turbo",  # or "gpt-4"
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": "Say hello world!"}
            ]
        )
        print("✅ OpenAI Response:", response.choices[0].message.content)
    except Exception as e:
        print("❌ Error:", e)

if __name__ == "__main__":
    test_openai()