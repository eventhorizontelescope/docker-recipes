# This Dockfiler builds the Haystack Observatory Postprocessing System
# (HOPS) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
# TODO: Make X11 work for pgplot and hence HOPS
#
#==============================================================================
# The builder image: use jessie because of libpng12
FROM debian:jessie-slim AS builder

# Setup build environment
RUN apt-get update && apt-get install -y \
		wget pkg-config make ghostscript bc \
		gcc gfortran python-setuptools \
		libx11-dev libpng12-dev libfftw3-dev &&\
	ln -s /usr/bin/f77 /usr/bin/g77 &&\
	rm -rf /var/lib/apt/lists/*

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
		/usr/include/zlib.h /usr/include/x86_64-linux-gnu/zconf.h . &&\
	make && make cpg &&\
	# Effectively `make install`
	mkdir -p /usr/local/pgplot &&\
	cp pgxwin_server cpgplot.h libcpgplot.a libpgplot.a libpgplot.so \
		grfont.dat rgb.txt /usr/local/pgplot

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

#==============================================================================
# The HOPS image: use jessie because of libpng12
FROM debian:jessie-slim

# Setup runtime environment
RUN apt-get update && apt-get install -y \
		ghostscript less csh \
		perl-doc python \
		libx11-6 libpng12-0 libfftw3-double3 &&\
	rm -rf /var/lib/apt/lists/*
COPY --from=builder \
		/usr/lib/x86_64-linux-gnu/libgfortran.so.3* \
		/usr/lib/x86_64-linux-gnu/libquadmath.so.0* \
		/usr/lib/x86_64-linux-gnu/

# Copy pgplot and HOPS from the builder image
COPY --from=builder /usr/local/pgplot /usr/local/pgplot
COPY --from=builder /usr/local/hops   /usr/local/hops
RUN printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  . /usr/local/hops/bin/hops.bash;\n\
fi\n' >> /etc/bash.bashrc

# `docker run -it <HOPS_img>` will run as "calibrator" in the HOPS environment
RUN useradd -ms /bin/bash calibrator
WORKDIR /home/calibrator
USER calibrator
