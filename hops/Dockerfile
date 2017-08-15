# Use jessie because of libpng12
FROM debian:jessie-slim

# Setup build environment
RUN apt-get update && apt-get install -y \
	wget pkg-config make ghostscript bc \
	gcc gfortran python-setuptools \
	libx11-dev libpng-dev libfftw3-dev && \
	ln -s /usr/bin/f77 /usr/bin/g77; \
	ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include/; \
	rm -rf /var/lib/apt/lists/*

# Build pgplot
WORKDIR /usr/local/pgplot
RUN wget ftp://ftp.astro.caltech.edu/pub/pgplot/pgplot5.2.tar.gz \
	    -P /usr/local/src/ &&\
	tar -vzxf /usr/local/src/pgplot5.2.tar.gz \
	    -C /usr/local/src &&\
	sed -e's/! PN/  PN/g' \
	    -e's/! PS/  PS/g' \
	    -e's/! XW/  XW/g' \
	    /usr/local/src/pgplot/drivers.list > drivers.list &&\
	/usr/local/src/pgplot/makemake /usr/local/src/pgplot linux g77_gcc &&\
	ln -s /usr/include/png.h /usr/include/pngconf.h \
	    /usr/include/zlib.h /usr/include/zconf.h . &&\
	make && make cpg

# Build HOPS
WORKDIR /usr/local/hops
RUN wget ftp://gemini.haystack.mit.edu/pub/hops/hops-3.16-1897.tar.gz \
	    -P /usr/local/src/ &&\
	tar -vzxf /usr/local/src/hops-3.16-1897.tar.gz \
	    -C /usr/local/src &&\
	/usr/local/src/hops-3.16/configure \
	    HOPS_ROOT=/root \
	    PGPLOT_DIR=/usr/local/pgplot \
	    --prefix=$PWD &&\
	make && make install &&\
	# because of how the test data is stored, `make check` must be
	# run after `make install`
	make check

# `docker run -it <HOPS_img>` will run as "calibrator" in the HOPS environment
RUN useradd -ms /bin/bash calibrator &&\
	printf 'if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  . /usr/local/hops/bin/hops.bash;\n\
fi\n' >> /home/calibrator/.bashrc
WORKDIR /home/calibrator
USER calibrator
