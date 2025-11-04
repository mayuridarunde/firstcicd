FROM python:3.10-slim

# Install basic build tools (no libarrow/libparquet)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install streamlit pandas

# Set working directory
WORKDIR /var

# Copy the Python file
COPY etl.py .

# Expose the Streamlit port
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "etl.py", "--server.port=8501", "--server.address=0.0.0.0"]

