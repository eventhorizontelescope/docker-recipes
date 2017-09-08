# This Dockfiler install jupyter notebook on top of the Haystack
# Observatory Postprocessing System (HOPS) and the Event Horizon
# Telescope Analysis Toolkit (EAT) for performing data calibration for
# the Event Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The EAT image
FROM chanchikwan/eat
USER root

# Install Jupyter
RUN apt-get update && apt-get install -y \
		jupyter-notebook jupyter-core \
		jupyter-nbextension-jupyter-js-widgets python-ipykernel &&\
	rm -rf /var/lib/apt/lists/*

# `docker run -it <HOPS-stack_img>` will run as "calibrator" in the HOPS staick
USER calibrator
