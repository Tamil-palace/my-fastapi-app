FROM python:3.10-slim

# Step 1: create non-root user
RUN useradd -m -u 1000 user

# Step 2: switch to that user
USER user

# Step 3: set PATH to include user's local bin
ENV PATH="/home/user/.local/bin:$PATH"
#   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   THIS is the missing line in most cases

# Step 4: set workdir
WORKDIR /app

# Step 5: copy and install
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 6: copy app code
COPY --chown=user . .

# Step 7: expose HF required port
EXPOSE 7860

# Step 8: run
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]