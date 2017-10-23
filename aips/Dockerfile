# This Dockfiler builds the Haystack Observatory Postprocessing System
# (HOPS) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The HOPS image
FROM	debian:stretch-slim

# Setup build environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y ca-certificates \
		curl rsync cvs libncurses5 &&\
	apt-get remove -y ca-certificates && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN	printf '\n# all users should source AIPS\n\
if [ -f /usr/local/aips/LOGIN.SH ]; then\n\
  source /usr/local/aips/LOGIN.SH\n\
fi\n' >> /etc/bash.bashrc

RUN	useradd -md /usr/local/aips -s /bin/bash aips
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
