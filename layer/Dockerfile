FROM public.ecr.aws/lambda/python:3.11

COPY google-chrome-stable_current_x86_64.rpm ./

# Install dependencies
RUN yum update -y

RUN yum install -y ./google-chrome-stable_current_x86_64.rpm

RUN ln -s /usr/bin/google-chrome-stable /usr/bin/chromium
RUN ln -s /usr/bin/google-chrome-stable /usr/bin/google-chrome
