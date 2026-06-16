# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir flask openpyxl gunicorn filelock

# Copy the current directory contents into the container
COPY app.py .

# Expose port 5000 for the Flask app
EXPOSE 5000

# Command to run the application
#CMD ["python", "app.py"]
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
