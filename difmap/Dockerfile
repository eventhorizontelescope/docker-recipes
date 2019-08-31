# This Dockfiler builds `difmap`, a program developed for synthesis
# imaging of visibility data from interferometer arrays of radio
# telescopes, for performing data calibration for the Event Horizon
# Telescope (EHT)'s April 2017 observations.
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
		zlib1g-dev libx11-dev libncurses5-dev wget &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build libpng12
WORKDIR	/usr/local/src/libpng/build
RUN	wget -q https://downloads.sourceforge.net/project/libpng/libpng12/1.2.59/libpng-1.2.59.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/libpng-1.2.59.tar.gz \
		-C /usr/local/src/libpng --strip-components=1 &&\
	../configure \
		--prefix=/usr/local/difmap \
		--libdir=/usr/local/difmap/lib/libpng12 &&\
	make && make check && make install

# Build pgplot
WORKDIR	/usr/local/src/pgplot/build
RUN	wget -q ftp://ftp.astro.caltech.edu/pub/pgplot/pgplot5.2.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/pgplot5.2.tar.gz \
		-C /usr/local/src/pgplot --strip-components=1 &&\
	ln -s	/usr/local/difmap/include/png.h \
		/usr/local/difmap/include/pngconf.h \
		/usr/include/zlib.h \
		/usr/include/zconf.h . &&\
	sed	-e's/! PN/  PN/g' \
		-e's/! PS/  PS/g' \
		-e's/! TTDRIV 5/  TTDRIV 5/g' \
		-e's/! XW/  XW/g' \
		../drivers.list > drivers.list &&\
	../makemake .. linux g77_gcc &&\
	sed	-e's|-lpng|-L/usr/local/difmap/lib/libpng12 -lpng|g' \
		-e's|FCOMPL=g77|FCOMPL=gfortran|g' \
		-i~ makefile &&\
	make && make cpg &&\
	mkdir -p /usr/local/difmap/lib/pgplot &&\
	cp pgxwin_server cpgplot.h lib* grfont.dat rgb.txt \
		/usr/local/difmap/lib/pgplot

# Build difmap
WORKDIR	/usr/local/src/difmap
RUN	wget -q ftp://ftp.astro.caltech.edu/pub/difmap/difmap2.5e.tar.gz \
		-P /usr/local/src &&\
	tar -zxf /usr/local/src/difmap2.5e.tar.gz \
		-C /usr/local/src/difmap --strip-components=2 &&\
	sed	-e's|^LDFLAGS=""$|LDFLAGS="-L/usr/local/difmap/lib/libpng12 -L/usr/local/difmap/lib/pgplot"|g' \
		-e's|^PGPLOT_LIB="-lpgplot -lX11"|PGPLOT_LIB="-lpgplot -Wl,-rpath=/usr/local/difmap/lib/pgplot -lpng -Wl,-rpath=/usr/local/difmap/lib/libpng12 -lX11"|g' \
		-i~ configure &&\
	./configure linux-i486-gcc &&\
	./makeall &&\
	cp    difmap /usr/local/difmap/bin &&\
	cp -r help   /usr/local/difmap/share

#==============================================================================
# The difmap image
FROM	debian:stretch-slim

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		libgfortran3 libquadmath0 zlib1g libx11-6 libncurses5 &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy HOPS from the builder image
COPY	--from=builder /usr/local/difmap /usr/local/difmap
RUN	printf '\n# place difmap path\n\
export PATH="/usr/local/difmap/bin:$PATH"\n' >> /etc/bash.bashrc

# `docker run -it <HOPS_img>` will run as "root" in the HOPS environment
WORKDIR	/root
