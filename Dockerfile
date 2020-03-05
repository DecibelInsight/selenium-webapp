FROM maven:3.6.3-jdk-11
MAINTAINER Automation Team <devops@decibelinsight.com>
RUN apt-get update && apt-get clean
RUN apt-get update && apt-get install -y libglib2.0-0 libnss3 libx11-6

COPY . /Selenium/

WORKDIR /Selenium

ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt update &&  apt install firefox-esr -y
