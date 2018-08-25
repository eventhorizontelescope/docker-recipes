# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The HOPS Stack image
FROM	eventhorizontelescope/hops-stack

# Clone eht-imaging source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/chanchikwan/ehtim.git &&\
	cd ehtim &&\
	pip install -e . &&\
	printf '\n# prepend the ehtim script path to $PATH\n\
export PATH="/usr/local/src/ehtim/scripts:$PATH"\n\
' >> /etc/bash.bashrc

# Clone ehtplot source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/liamedeiros/ehtplot.git &&\
	cd ehtplot &&\
	pip install -e .
