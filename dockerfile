FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y curl

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential

# install wkhtmltopdf
RUN apt-get install -y xvfb libfontconfig wkhtmltopdf

# alias cmd
RUN printf '#!/bin/bash\nxvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf -q $*' > /usr/bin/wkhtmltopdf.sh
RUN chmod a+x /usr/bin/wkhtmltopdf.sh
RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf

RUN mkdir -p /usr/src
WORKDIR /usr/src

COPY package.json .
COPY package-lock.json .
RUN npm install

ADD index.js .

CMD [ "npm", "start" ]
