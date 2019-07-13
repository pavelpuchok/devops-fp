FROM python:3.6-alpine as builder
WORKDIR /app
COPY requirements.txt .
COPY crawler crawler
RUN pip install -r requirements.txt

FROM builder as unit-test
COPY tests ./tests
COPY requirements-test.txt requirements-test.txt
RUN pip install -r requirements-test.txt
RUN python -m unittest discover -s tests/

FROM unit-test as coverage
RUN coverage run -m unittest discover -s tests/
RUN coverage report --include crawler/crawler.py

FROM builder
EXPOSE 8000
ENV MONGO mongo
ENV MONGO_PORT 27017
ENV RMQ_HOST rmq
ENV RMQ_QUEUE crawler
ENV RMQ_USERNAME crawler
ENV RMQ_PASSWORD crawler
ENV CHECK_INTERVAL 1
ENV EXCLUDE_URLS .*github.com
ENV START_URL https://vitkhab.github.io/search_engine_test_site
CMD python -u crawler/crawler.py ${START_URL}
