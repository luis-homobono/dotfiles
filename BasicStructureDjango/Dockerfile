FROM python:alpine
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app


# Copy local contents into the container
# Install all requirements dependencies 
RUN apk update \
    && apk add --no-cache gcc musl-dev postgresql-dev python3-dev libffi-dev \
    && pip install --upgrade pip


COPY .requirements.txt ./
RUN pip install -r requirements.txt
COPY ./ ./
# EXPOSE 5000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# docker build -t luishomobono/docker-django .
# docker run -p 8000:8000 luishomobono/docker-django