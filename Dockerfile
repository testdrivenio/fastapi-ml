# Use an official lightweight Python base image
FROM python:3.11-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN pip install --upgrade setuptools
RUN pip install \
    cython==0.29.34 \
    numpy==1.24.3 \
    pandas==2.0.1 \
    pystan==3.7.0

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Remove unnecessary files (like .pyc files)
RUN find /app -name '*.pyc' -delete

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
