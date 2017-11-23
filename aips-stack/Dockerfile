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
FROM	eventhorizontelescope/aips

# Install ParselTongue
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y software-properties-common &&\
	add-apt-repository ppa:kettenis-w/parseltongue &&\
	apt-get -qq update &&\
	apt-get install --no-install-recommends -y parseltongue &&\
	apt-get remove -y software-properties-common && apt-get autoremove -y &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
