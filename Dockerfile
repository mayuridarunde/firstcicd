FROM python:3.14-slim
# Install required system dependencies for building PyArrow
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
#  Upgrade pip to latest version
RUN pip install --upgrade pip
RUN pip install streamlit
WORKDIR /var
COPY etl.py .
EXPOSE 8501
CMD ["streamlit", "run", "etl.py"]
