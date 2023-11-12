FROM python:latest
COPY requirements.txt .
RUN ["pip", "install", "-r", "requirements.txt"]
COPY *.py ./
ENTRYPOINT [ "python", "bot.py" ]