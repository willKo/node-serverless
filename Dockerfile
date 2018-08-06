FROM amazonlinux:latest

# jdk for sonar-scanner
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y git 
RUN yum install -y gcc-c++ make 
RUN yum install -y openssl-devel 

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.2
WORKDIR $NVM_DIR
#isntall tar
RUN yum -y update && \
    yum -y install wget && \
    yum install -y tar.x86_64 && \
    yum clean all
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default 

ENV LDFLAGS=-Wl,-rpath=/var/task/
RUN yum install cairo cairo-devel libjpeg8-devel libjpeg-turbo-devel automake gcc kernel-devel   cairomm-devel  pango pango-devel pangomm pangomm-devel giflib-devel  -y
ENV PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'  
ENV LD_LIBRARY_PATH='/usr/local/lib':$LD_LIBRARY_PATH  

RUN npm install -g serverless
RUN npm install -g node-gyp
RUN npm install -g canvas
RUN npm install -g fabric
RUN npm install -g jsdom
RUN cd /usr/local/lib/node_modules/canvas && node-gyp rebuild
RUN cd /usr/local/lib/node_modules/jsdom/node_modules/contextify && node-gyp rebuild
