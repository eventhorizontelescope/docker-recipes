# This Dockfiler builds DiFX for the Event Horizon Telescope (EHT)'s
# April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The builder image
FROM	debian:stretch-slim AS builder

# Setup build environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		ca-certificates subversion \
		make autoconf automake libtool pkg-config \
		bison flex g++ gfortran libopenmpi-dev openmpi-bin python \
		libexpat1-dev libfftw3-dev &&\
	apt-get autoremove -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build DiFX
WORKDIR	/usr/local/src/difx
RUN	svn co https://svn.atnf.csiro.au/difx/master_tags/DiFX-2.5.1 . &&\
	bash -c '. setup.bash && ./install-difx --noipp'
