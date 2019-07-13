FROM python:3.6-alpine as builder
WORKDIR /app
COPY requirements.txt .
COPY ui ui
RUN pip install -r requirements.txt

FROM builder as unit-test
COPY tests ./tests
COPY requirements-test.txt requirements-test.txt
RUN pip install -r requirements-test.txt
RUN python -m unittest discover -s tests/

FROM unit-test as coverage
RUN coverage run -m unittest discover -s tests/
RUN coverage report --include ui/ui.py

FROM builder
WORKDIR /app/ui
EXPOSE 8000
ENV FLASK_APP=ui.py
CMD [ "gunicorn", "ui:app", "-b", "0.0.0.0" ]
