# This Dockfiler install jupyter lab on top the Event Horizon
# Telescope Analysis Toolkit (EAT) for performing data calibration for
# the Event Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The EAT Lab image
FROM	eventhorizontelescope/eat-notebook

# Install Jupyter and other visualization packages
RUN	apt-get -qq update &&\
        apt-get install --no-install-recommends -y gcc python-dev &&\
	apt-get remove -y python-matplotlib python-subprocess32 &&\
	pip install matplotlib jupyterlab &&\
	apt-get remove -y gcc python-dev &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	jupyter serverextension enable --py --sys-prefix jupyterlab

# By default we start a Jupyter Lab
ADD	lab.sh /
CMD	/lab.sh

# To use Jupyter Lab, run the following from the host:
#
#	docker run --rm -p8888:8888 -it eventhorizontelescope/hops-lab
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
