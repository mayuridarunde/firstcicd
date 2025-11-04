FROM python:3.10-slim
# Install required system dependencies for building PyArrow
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    libarrow-dev \
    libparquet-dev \
    && rm -rf /var/lib/apt/lists/*
#  Upgrade pip to latest version
RUN pip install --no-cache-dir --upgrade pip

#  Install Python libraries used in your script
RUN pip install --no-cache-dir streamlit pandas
WORKDIR /var
COPY etl.py .
EXPOSE 8501
CMD ["streamlit", "run", "etl.py","--server.port=8501", "--server.address=0.0.0.0"]]
