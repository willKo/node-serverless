FROM amazonlinux:latest

#jdk for 
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y git 
RUN yum install -y gcc-c++ make 
RUN yum install -y openssl-devel 
RUN git clone https://github.com/nodejs/node.git 
RUN cd ./node/ &&  ls -l &&  git checkout v6.10.2 &&  git checkout v6.10.2 &&  ./configure &&  make &&  make install 

ENV LDFLAGS=-Wl,-rpath=/var/task/
RUN yum install cairo cairo-devel libjpeg8-devel libjpeg-turbo-devel automake gcc kernel-devel   -y
ENV PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'  
ENV LD_LIBRARY_PATH='/usr/local/lib':$LD_LIBRARY_PATH  


RUN npm install -g node-gyp@6.10.2
RUN npm install -g canvas@1.6.7
RUN npm install -g fabric@1.7.14

RUN cd /usr/local/lib/node_modules/canvas && node-gyp rebuild
