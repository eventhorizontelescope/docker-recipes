# This Dockfiler builds the Haystack Observatory Postprocessing System
# (HOPS) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The builder image
FROM chanchikwan/hops AS builder
USER root

# Setup build environment
RUN apt-get update && apt-get install -y git python-setuptools &&\
	rm -rf /var/lib/apt/lists/*

# Get EAT source
WORKDIR /usr/local/src
RUN git clone https://github.com/sao-eht/eat.git &&\
	rm -rf eat/.git

#==============================================================================
# The HOPS image
FROM chanchikwan/hops
USER root

# Setup runtime environment
RUN apt-get update && apt-get install -y --no-install-recommends \
		python-astropy python-future python-matplotlib python-pandas \
		python-scipy python-setuptools python-pip &&\
	rm -rf /var/lib/apt/lists/*

# Copy EAT source and install it
COPY --from=builder /usr/local/src/eat /usr/local/src/eat
RUN cd /usr/local/src/eat && pip install .

# `docker run -it <HOPS_img>` will run as "calibrator" in the HOPS environment
USER calibrator
