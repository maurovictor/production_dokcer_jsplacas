FROM ubuntu:14.04 

RUN apt-get update -y
RUN apt-get install -y build-essential python3-dev python3-pip python3-setuptools vim wget curl git 


## Installing the external libraries for Pillow(One of the packages needed for the application)
RUN apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk 

## Cloning the content from git repository 
RUN git clone https://github.com/maurovictor/js_flask

## Changing work directory 
WORKDIR js_flask 

## Installing necessary python packages
RUN pip3 install -r requirements.txt
## Flask environment variables 
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV FLASK_APP="application.py"

## Necessary to route some port with -p or -P parameter
## Expose port 5000 
EXPOSE 80

CMD uwsgi --http 0.0.0.0:80 --wsgi-file application.py --callable app --processes 4 --threads 2 --stats 0.0.0.0:9191
