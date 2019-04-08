# This Dockfiler builds `img-env`, the Event Horizon Telescope imaging
# envirment, for reproducing the first results from its April 2017
# observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The img-env image
FROM	eventhorizontelescope/difmap

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		git expect g++ gfortran make pkg-config libfftw3-dev saods9 \
		python-setuptools  python-pip  python-future  python-ephem  python-tk \
		python3-setuptools python3-pip python3-future python3-ephem python3-tk \
		python-dev python-subprocess32 python-pyds9 python-pynfft &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN	cd /usr/local/src && git clone https://github.com/xianyi/OpenBLAS && cd OpenBLAS &&\
	make USE_OPENMP=1 CC=gcc &&\
	make PREFIX=/usr/local install &&\
	cd
RUN	pip2 install --upgrade pip &&\
	pip3 install --upgrade pip &&\
	hash -r &&\
	pip2 install --upgrade numpy &&\
	pip3 install --upgrade numpy &&\
	pip2 install pandas

# Install eht-imaging
RUN	pip2 install ipython git+https://github.com/achael/eht-imaging.git@v1.1.0 &&\
	pip3 install ipython git+https://github.com/achael/eht-imaging.git@v1.1.0

# Install SMILI
RUN	cd /usr/local/bin && mv f2py f2py- && cp /usr/bin/f2py2.7 f2py &&\
	cd /usr/local && git clone https://github.com/astrosmili/smili && cd smili &&\
	./configure && make install &&\
	cd /usr/local/bin && rm f2py && mv f2py- f2py &&\
	cd
ENV	LD_LIBRARY_PATH=/usr/local/lib PYDS9_NOXPANS=
