FROM public.ecr.aws/lambda/python:3.11

# Install dependencies.
RUN yum update -y && yum install -y amazon-linux-extras

# Enable and install Extra Packages for Enterprise Linux by running the command
RUN PYTHON=python2 amazon-linux-extras install epel -y

# Post installing all the extra packages successfully, Install chromimum as usual
RUN yum install -y chromium chromedriver

COPY requirements.txt ./requirements.txt

RUN python3.11 -m pip install -r requirements.txt -t .

COPY . ./
