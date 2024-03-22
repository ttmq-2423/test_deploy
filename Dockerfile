# app/Dockerfile

# Use the Python 3.9 slim image as the base image
FROM python:3.9-slim

# Copy the current directory contents into the container at /app
COPY . /app

# Set the working directory in the container to /app
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose port 80
EXPOSE 80

# Set the health check command
HEALTHCHECK CMD curl --fail http://localhost:80/_stcore/health

# Set the default command to run the Streamlit app
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=80", "--server.address=0.0.0.0"]

