# Step 1: base image
FROM python:3.10-slim

# Step 2: HF Space runs as non-root user (uid=1000)
# MUST set this or permission errors will hit you
RUN useradd -m -u 1000 user
USER user

# Step 3: set working dir
WORKDIR /app

# Step 4: install deps
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: copy your code
COPY --chown=user . .

# Step 6: HF Docker Space ALWAYS exposes port 7860
# your app MUST listen on 7860
EXPOSE 7860

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]