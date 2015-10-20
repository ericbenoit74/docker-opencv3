FROM ubuntu:14.04

RUN echo 'deb http://archive.ubuntu.com/ubuntu precise multiverse' >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y wget unzip git
RUN apt-get install -y build-essential checkinstall pkg-config yasm libtiff-dev libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev python-dev python-numpy libtbb2 libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils libboost-all-dev 


WORKDIR /tmp

RUN wget http://www.cmake.org/files/v3.3/cmake-3.3.0.tar.gz
RUN tar xf cmake-3.3.0.tar.gz
WORKDIR /tmp/cmake-3.3.0
RUN ./configure
RUN make
RUN checkinstall -y

WORKDIR /tmp
RUN wget https://github.com/Itseez/opencv/archive/3.0.0.zip
RUN unzip 3.0.0.zip

WORKDIR /tmp/opencv-3.0.0
RUN mkdir /tmp/opencv-3.0.0/build

WORKDIR /tmp/opencv-3.0.0/build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..
RUN make -j2
RUN make install
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf
RUN ldconfig

WORKDIR /
RUN rm -rf /tmp/*

