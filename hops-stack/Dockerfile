# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
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
	apt-get install --no-install-recommends -y \
		ca-certificates git &&\
 	apt-get remove -y ca-certificates &&\
	apt-get autoremove -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get EAT source
WORKDIR	/usr/local/src
RUN	git clone https://github.com/sao-eht/eat.git &&\
	rm -rf eat/.git

#==============================================================================
# The EAT image
FROM	chanchikwan/hops

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		python-pip python-ipython python-subprocess32 &&\
 	apt-get remove -y python-backports-shutil-get-terminal-size &&\
	apt-get autoremove -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN	pip install --upgrade pip &&\
	pip install wheel setuptools &&\
	pip install future ipython
RUN	pip install scipy astropy pandas
RUN	pip install matplotlib bokeh

# Copy EAT source and install it
COPY	--from=builder /usr/local/src/eat /usr/local/src/eat
RUN	cd /usr/local/src/eat &&\
	pip install . &&\
	printf '\n# prepend the EAT script path to $PATH\n\
  export PATH="/usr/local/src/eat/bin:$PATH"\n\
' >> /etc/bash.bashrc
