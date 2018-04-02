#we use ubuntu as our base distro for this container
FROM debian:jessie
#refresh apt-get
RUN apt-get update
#install some utilities needed by node,npm, and zeroMq
RUN apt-get install -y curl make g++
#run apt-get install curl

#install node.js and npm.
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

#install require npm packages
COPY src/ /src/
WORKDIR /src
RUN npm install
RUN npm install cors

#open up external acces to port 80
EXPOSE 8081

#run startup command
CMD ["node","/src/shop.js"]
