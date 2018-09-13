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
FROM	debian:stretch-slim AS builder

# Setup build environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		pkg-config make gcc gfortran automake autoconf libtool \
		libfftw3-dev zlib1g-dev libx11-dev \
		bc ghostscript-x patch python-setuptools python-future wget &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build libpng12
WORKDIR	/usr/local/src/libpng/build
RUN	wget -q https://downloads.sourceforge.net/project/libpng/libpng12/1.2.59/libpng-1.2.59.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/libpng-1.2.59.tar.gz \
		-C /usr/local/src/libpng --strip-components=1 &&\
	../configure \
		--prefix=/usr/local/hops \
		--libdir=/usr/local/hops/lib/libpng12 &&\
	make && make check && make install

# Build pgplot
WORKDIR	/usr/local/src/pgplot/build
RUN	wget -q ftp://ftp.astro.caltech.edu/pub/pgplot/pgplot5.2.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/pgplot5.2.tar.gz \
		-C /usr/local/src/pgplot --strip-components=1 &&\
	ln -s	/usr/local/hops/include/png.h \
		/usr/local/hops/include/pngconf.h \
		/usr/include/zlib.h \
		/usr/include/zconf.h . &&\
	sed	-e's/! PN/  PN/g' \
		-e's/! PS/  PS/g' \
		-e's/! TTDRIV 5/  TTDRIV 5/g' \
		-e's/! XW/  XW/g' \
		../drivers.list > drivers.list &&\
	../makemake .. linux g77_gcc &&\
	sed	-e's|-lpng|-L/usr/local/hops/lib/libpng12 -lpng|g' \
		-e's|FCOMPL=g77|FCOMPL=gfortran|g' \
		-i~ makefile &&\
	make && make cpg &&\
	mkdir -p /usr/local/hops/lib/pgplot &&\
	cp pgxwin_server cpgplot.h lib* grfont.dat rgb.txt \
		/usr/local/hops/lib/pgplot

# Build HOPS
WORKDIR	/usr/local/src/hops/build
ADD	afio.py.in.diff mk4.py.in.diff /usr/local/src/hops/
RUN	wget -q --no-check-certificate \
		https://35.199.26.203/software/hops/hops-dv-difx-tc-3.19swc.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/hops-dv-difx-tc-3.19swc.tar.gz \
		-C /usr/local/src/hops --strip-components=1 &&\
	cd /usr/local/src/hops/sub/mk4py/ &&\
	patch < ../../afio.py.in.diff &&\
	patch < ../../mk4.py.in.diff  &&\
	cd /usr/local/src/hops/build &&\
	export HOPS_ROOT=/root &&\
	../configure \
		--prefix=/usr/local/hops \
		--enable-devel \
		CPPFLAGS='-I/usr/local/hops/include' \
		LDFLAGS='-L/usr/local/hops/lib/libpng12' \
		PGPLOT_DIR=/usr/local/hops/lib/pgplot &&\
	. ./hops.bash &&\
	make && make install && make check

#==============================================================================
# The HOPS image
FROM	debian:stretch-slim

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		libgfortran3 libquadmath0 libfftw3-double3 zlib1g libx11-6 \
		csh ghostscript-x less perl-doc &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy HOPS from the builder image
COPY	--from=builder /usr/local/hops /usr/local/hops
RUN	printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  source /usr/local/hops/bin/hops.bash\n\
fi\n' >> /etc/bash.bashrc

# `docker run -it <HOPS_img>` will run as "root" in the HOPS environment
WORKDIR	/root
