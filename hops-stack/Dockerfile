# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The EAT image
FROM	chanchikwan/hops

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		git python-pip python-ipython python-subprocess32 &&\
 	apt-get remove -y python-backports-shutil-get-terminal-size &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip install --upgrade pip &&\
	pip install wheel setuptools &&\
	pip install future ipython

# Copy EAT source and install it
RUN	cd /usr/local/src &&\
	git clone https://github.com/sao-eht/eat.git &&\
	cd eat &&\
	pip install -e . &&\
	printf '\n# prepend the EAT script path to $PATH\n\
  export PATH="/usr/local/src/eat/bin:$PATH"\n\
' >> /etc/bash.bashrc

# Get python data science stack
RUN	pip install scipy astropy pandas
RUN	pip install matplotlib bokeh
