# Stage 1: Base
FROM python:3.12-slim AS base
WORKDIR /app

# Only the essentials for Python runtime
RUN apt-get update && apt-get install -y \
    libmariadb3 \
    && rm -rf /var/lib/apt/lists/*

# Stage 2: Dependencies
FROM base AS dependencies
COPY requirements.txt .

# Use --prefer-binary to ensure Pandas/Numpy use pre-compiled "wheels"
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefer-binary -r requirements.txt

# Stage 3: Development
FROM dependencies AS development
COPY . .
# We reference the app via the environment variable
ENV FLASK_APP=flaskr
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]

# Stage 4: Production
FROM dependencies AS production
COPY . .
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "flaskr:create_app()"]