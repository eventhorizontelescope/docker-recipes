# This Dockfiler builds the Haystack Observatory Postprocessing System
# (HOPS) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The builder image
FROM debian:stretch-slim AS builder

# Setup build environment
RUN apt-get update && apt-get install -y \
		wget git pkg-config make ghostscript-x bc \
		gcc gfortran python-setuptools \
		zlib1g-dev libx11-dev libfftw3-dev &&\
	ln -s /usr/bin/f77 /usr/bin/g77 &&\
	rm -rf /var/lib/apt/lists/*

# Build libpng12
WORKDIR /usr/local/src/libpng/build
RUN wget -q https://download.sourceforge.net/libpng/libpng-1.2.58.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/libpng-1.2.58.tar.gz \
		-C /usr/local/src/libpng --strip-components=1 &&\
	../configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu &&\
	make && make install

# Build pgplot
WORKDIR /usr/local/src/pgplot/build
RUN wget -q ftp://ftp.astro.caltech.edu/pub/pgplot/pgplot5.2.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/pgplot5.2.tar.gz \
		-C /usr/local/src/pgplot --strip-components=1 &&\
	sed -e's/! PN/  PN/g' \
		-e's/! PS/  PS/g' \
		-e's/! TTDRIV 5/  TTDRIV 5/g' \
		-e's/! XW/  XW/g' \
		../drivers.list > drivers.list &&\
	../makemake .. linux g77_gcc &&\
	ln -s /usr/include/png.h /usr/include/pngconf.h \
		/usr/include/zlib.h /usr/include/zconf.h . &&\
	make && make cpg &&\
	# Effectively `make install`
	mkdir -p /usr/local/pgplot &&\
	cp pgxwin_server cpgplot.h lib* grfont.dat rgb.txt /usr/local/pgplot

# Build HOPS
WORKDIR /usr/local/src/hops/build
RUN wget -q ftp://gemini.haystack.mit.edu/pub/hops/hops-3.16-1897.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/hops-3.16-1897.tar.gz \
		-C /usr/local/src/hops --strip-components=1 &&\
	../configure \
		HOPS_ROOT=/home/calibrator \
		PGPLOT_DIR=/usr/local/pgplot \
		--prefix=/usr/local/hops &&\
	make && make check &&\
	make install

# Get EAT source
WORKDIR /usr/local/src
RUN git clone https://github.com/sao-eht/eat.git &&\
	rm -rf eat/.git

#==============================================================================
# The HOPS image
FROM debian:stretch-slim

# Setup runtime environment
RUN apt-get update && apt-get install -y --no-install-recommends \
		sudo ghostscript-x gv less csh \
		zlib1g libx11-6 libfftw3-double3 \
		perl-doc python python-astropy python-future \
		python-matplotlib python-pandas python-scipy \
		python-setuptools python-pip &&\
	rm -rf /var/lib/apt/lists/* &&\
	ln -s	/usr/lib/x86_64-linux-gnu/libpng12.so.0.58.0 \
		/usr/lib/x86_64-linux-gnu/libpng12.so.0
COPY --from=builder \
		/usr/lib/x86_64-linux-gnu/libpng12.so.0.58.0 \
		/usr/lib/x86_64-linux-gnu/

# Copy pgplot and HOPS from the builder image
COPY --from=builder /usr/local/pgplot /usr/local/pgplot
COPY --from=builder /usr/local/hops   /usr/local/hops
RUN printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  . /usr/local/hops/bin/hops.bash;\n\
fi\n' >> /etc/bash.bashrc

# Copy EAT source and install it
COPY --from=builder /usr/local/src/eat /usr/local/src/eat
RUN cd /usr/local/src/eat && pip install .

# Install jupyter
RUN apt-get update && apt-get install -y \
		jupyter-notebook jupyter-core \
		jupyter-nbextension-jupyter-js-widgets python-ipykernel &&\
	rm -rf /var/lib/apt/lists/*

# `docker run -it <HOPS_img>` will run as "calibrator" in the HOPS environment
RUN useradd -ms /bin/bash calibrator && echo "calibrator:calibrator" | chpasswd && adduser calibrator sudo
WORKDIR /home/calibrator
USER calibrator
