FROM ubuntu

RUN apt update && apt upgrade -y && apt install -y build-essential gcc nasm
COPY . .
