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
FROM chanchikwan/eat
USER root

# Install jupyter
RUN apt-get update && apt-get install -y \
		jupyter-notebook jupyter-core \
		jupyter-nbextension-jupyter-js-widgets python-ipykernel &&\
	rm -rf /var/lib/apt/lists/*

# `docker run -it <HOPS_img>` will run as "calibrator" in the HOPS environment
USER calibrator
