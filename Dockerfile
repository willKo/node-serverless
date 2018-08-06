FROM amazonlinux:latest

# jdk for sonar-scanner
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y git 
RUN yum install -y gcc-c++ make 
RUN yum install -y openssl-devel 
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs

ENV LDFLAGS=-Wl,-rpath=/var/task/
RUN yum install cairo cairo-devel libjpeg8-devel libjpeg-turbo-devel automake gcc kernel-devel   -y
ENV PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'  
ENV LD_LIBRARY_PATH='/usr/local/lib':$LD_LIBRARY_PATH  
RUN npm install -g serverless

RUN npm install -g node-gyp
RUN npm install -g canvas
RUN npm install -g fabric
RUN npm install -g jsdom
RUN cd /usr/local/lib/node_modules/canvas && node-gyp rebuild
RUN cd /usr/local/lib/node_modules/jsdom/node_modules/contextify && node-gyp rebuild
