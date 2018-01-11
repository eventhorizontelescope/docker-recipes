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
RUN	mkdir -p /run/sendsigs.omit.d &&\
	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		subversion make autoconf automake libtool pkg-config \
		bison flex g++ gfortran openmpi-bin rpcbind netbase python \
		libexpat1-dev libfftw3-dev libopenmpi-dev &&\
	apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build DiFX
WORKDIR	/usr/local/src/difx
RUN	svn co https://svn.atnf.csiro.au/difx/master_tags/DiFX-2.5.1 . &&\
	bash -c '. setup.bash && ./install-difx --noipp' &&\
	cp	setup.bash setup.csh /usr/local/difx/bin &&\
	sed	-e's|/bin/sh|/bin/bash|' \
		applications/calcserver/init.d/calcserver >\
		/usr/local/difx/share/CalcServer/calcserver &&\
	chmod 755 /usr/local/difx/share/CalcServer/calcserver

#==============================================================================
# The DiFX image
FROM	debian:stretch-slim

# Setup runtime environment
RUN	mkdir -p /run/sendsigs.omit.d &&\
	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		tmux ssh openmpi-bin rpcbind netbase python libexpat1 libfftw3-3 &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy DiFX from the builder image
COPY	--from=builder /usr/local/difx /usr/local/difx
RUN	cp	/usr/local/difx/share/CalcServer/calcserver /etc/init.d/ &&\
	printf '\n# all users should be able to load difx libraries\n\
if [ -d /usr/local/difx ]; then\n\
  source /usr/local/difx/bin/setup.bash\n\
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/difx/lib\n\
  export PATH=$PATH:/usr/local/difx/bin\n\
fi\n' >> /etc/bash.bashrc

# `docker run -it <DIFX_img>` will run as "root"
WORKDIR	/root
