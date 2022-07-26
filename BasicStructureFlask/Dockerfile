FROM python
# Set work directory
WORKDIR /app
# Copy local contents into the container
ADD . /app
# Install all requirements dependencies 
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "main.py"]