# A full dev suite for Opencv 3.
## Content
- Opencv 3.0.0
- CMAKE 3 is installed instead of CMAKE 2.8.4
- g++ and Boost library
- OS is fixed on Ubuntu:14.04
- ffmpeg is replaced by avconv
Usage:
```bash
docker run  -it --rm -v /home/myhome:/home ericbenoit/ubuntu-cmake3-opencv /bin/bash
```

## If you want to use programs with a GUI:
On the host, you need to authorize X11 connections before starting the container:
```bash
xhost +
docker run  -it --rm -v /home/myhome:/home -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix ericbenoit/ubuntu-cmake3-opencv /bin/bash
```
Inside the container, precede the program by QT_X11_NO_MITSHM=1:
```bash
QT_X11_NO_MITSHM=1 my_program_with_a_GUI
```

