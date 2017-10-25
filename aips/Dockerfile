# This Dockfiler builds the National Radio Astronomy Observatory
# (NRAO) Astronomical Image Processing System (AIPS) for performing
# data calibration for the Event Horizon Telescope (EHT)'s April 2017
# observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The AIPS image
FROM	ubuntu:xenial

# Setup build environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		sudo curl rsync cvs procps xterm libncurses5 &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# AIPS doesn't like running as root
RUN	useradd -md /usr/local/aips -s /bin/bash aips &&\
	echo "aips:aips" | chpasswd &&\
	adduser aips sudo
WORKDIR	/usr/local/aips
USER	aips

# Install AIPS 31DEC16
ADD	AIPSRC16 .AIPSRC
RUN	curl -O ftp://ftp.aoc.nrao.edu/pub/software/aips/31DEC16/install.pl &&\
	chmod 755 install.pl &&\
	./install.pl -n

# Install AIPS 31DEC17
ADD	AIPSRC17 .AIPSRC
RUN	curl -O ftp://ftp.aoc.nrao.edu/pub/software/aips/31DEC17/install.pl &&\
	chmod 755 install.pl &&\
	./install.pl -n

# Setup AIPS
USER	root
RUN	printf '\n\
sssin           5000/tcp        SSSIN      # AIPS TV server\n\
ssslock         5002/tcp        SSSLOCK    # AIPS TV Lock\n\
msgserv         5008/tcp        MSGSERV    # AIPS Message Server\n\
tekserv         5009/tcp        TEKSERV    # AIPS TekServer\n\
aipsmt0         5010/tcp        AIPSMT0    # AIPS remote FITS disk access\n\
aipsmt1         5011/tcp        AIPSMT1    # AIPS remote tape 1\n\
aipsmt2         5012/tcp        AIPSMT2    # AIPS remote tape 2\n\
' >> /root/services &&\
	printf '\n# all users should source AIPS\n\
if [ -f /usr/local/aips/LOGIN.SH ]; then\n\
  source /usr/local/aips/LOGIN.SH\n\
fi\n\
' >> /etc/bash.bashrc

# Install ParselTongue
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y software-properties-common &&\
	add-apt-repository ppa:kettenis-w/parseltongue &&\
	apt-get -qq update &&\
	apt-get install --no-install-recommends -y parseltongue &&\
	apt-get remove -y software-properties-common && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
