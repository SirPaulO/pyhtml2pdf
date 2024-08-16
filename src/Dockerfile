FROM public.ecr.aws/lambda/python:3.11

# Versions
ENV CHROME_DRIVER_VERSION="curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE"

COPY google-chrome.repo /etc/yum.repos.d/google-chrome.repo

# Install dependencies.
RUN yum update -y \
    && yum install -y unzip xvfb libxi6 libgconf-2-4 wget

# Install Chrome.
# vi /etc/yum.repos.d/google-chrome.repo

# RUN cat /etc/yum.repos.d/google-chrome.repo

# Make sure you have below info in the file(remove hash).
#[google-chrome]
#name=google-chrome
#baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
#enabled=1
#gpgcheck=1
#gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
    && yum install -y ./google-chrome-stable_current_x86_64.rpm

COPY . ./

RUN python3.11 -m pip install -r requirements.txt -t .

# Command can be overwritten by providing a different command in the template directly.
CMD ["app.lambda_handler"]
