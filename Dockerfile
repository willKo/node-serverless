FROM amazonlinux:latest

# jdk for sonar-scanner
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y git
RUN yum install -y gcc-c++ make
RUN yum install -y openssl-devel


# install tar
RUN yum -y update && \
  yum -y install wget && \
  yum install -y tar.x86_64 && \
  yum clean all




ENV LDFLAGS=-Wl,-rpath=/var/task/
RUN yum install cairo cairo-devel libjpeg8-devel libjpeg-turbo-devel automake gcc kernel-devel  cairomm-devel  pango pango-devel pangomm pangomm-devel giflib-devel  -y
ENV PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'
#

RUN mkdir -p /usr/mylib/
RUN ls /usr/lib64/
# was libpng12.so.0
RUN cp /usr/lib64/{libpng15.so,libpng15.so.15,libjpeg.so.62,libgraphite2.so.3,libpixman-1.so.0,libfreetype.so.6,libcairo.so.2,libthai.so.0,libpango-1.0.so.0,libharfbuzz.so.0,libpangocairo-1.0.so.0,libpangoft2-1.0.so.0} /usr/mylib/
RUN chmod u+x /usr/mylib/**


ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.2
WORKDIR $NVM_DIR

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default \
  && node -e "console.log('Running Node.js ' + process.version)"

RUN ls /usr/lib64/
ENV LD_LIBRARY_PATH=/lib/:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/lib64/:$LD_LIBRARY_PATH



RUN npm install -g serverless
RUN npm install -g node-gyp
RUN npm install -g jsdom
RUN npm install -g canvas
RUN npm install -g fabric
RUN node -v
RUN npm -v
RUN  npm list -g


RUN cd /usr/local/nvm/versions/node/v6.10.2/lib/node_modules/canvas && node-gyp rebuild
# RUN cd /usr/local/nvm/versions/node/v6.10.2/lib/node_modules/jsdom/node_modules/contextify && node-gyp rebuild
RUN ldconfig

RUN echo $LD_LIBRARY_PATH
