# Use a base image with a pre-installed JDK and Scala
FROM openjdk:8-jdk-alpine

# Install any additional dependencies required for the project
RUN apk add --no-cache curl tar \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        python-dev \
        libffi-dev \
        openssl-dev \
    && apk add --no-cache --virtual .run-deps \
        python \
        openssl

# Install pip
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
    && python get-pip.py

# Install the Spark, Cassandra, Elasticsearch, Redis, Hadoop, Zookeeper, Kubernetes, Flask, PostgreSQL, RabbitMQ, Ansible, Logstash, Grafana, Jenkins, Java, Scala, Thrift, and OpenSSL dependencies
RUN pip install spark cassandra elasticsearch redis hadoop zookeeper kubernetes flask psycopg2 pika ansible logstash grafana jenkins java scala thrift pyOpenSSL

# Set the working directory
WORKDIR /app

# Copy your application code into the container
COPY . /app

# Set the environment variables
ENV SPARK_MASTER "spark://spark-master:7077"
ENV SPARK_WORKER_MEMORY "2g"

# Expose the port for your application
EXPOSE 4040

# Start the application
CMD [ "./run.sh" ]
