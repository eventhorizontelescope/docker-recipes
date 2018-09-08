# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The HOPS image
FROM	eventhorizontelescope/hops

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		git liblist-moreutils-perl parallel emacs vim time \
		python-setuptools python-pip python-future python-tk python-ephem \
		python-pandas python-scipy python-astropy \
		python-matplotlib python-seaborn &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip install --upgrade pip pandas

# Clone EAT source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/sao-eht/eat.git &&\
	cd eat &&\
	pip install -e . &&\
	printf '\n# prepend the EAT script path to $PATH\n\
export PATH="/usr/local/src/eat/bin:$PATH"\n\
' >> /etc/bash.bashrc

# Clone hopstools source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/klbouman/hopstools.git &&\
	printf '\n# prepend the hopstool path to $PATH\n\
export PATH="/usr/local/src/hopstools:$PATH"\n\
' >> /etc/bash.bashrc
