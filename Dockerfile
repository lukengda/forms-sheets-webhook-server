# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Bring in the uv binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set the working directory in the container
WORKDIR /app

# Install locked dependencies first (cached unless the lockfile changes)
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy the application
COPY app.py .

# Expose port 5000 for the Flask app
EXPOSE 5000

# Command to run the application via gunicorn from the synced environment
CMD ["uv", "run", "--frozen", "--no-dev", "gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
