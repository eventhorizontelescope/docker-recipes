# This Dockfiler install jupyter lab on top of the Haystack
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
FROM chanchikwan/hops-stack

# Install Jupyter and other visualization packages
RUN pip install jupyterlab &&\
	jupyter serverextension enable --py jupyterlab --sys-prefix

# By default we start a Jupyter Lab
ADD lab.sh /
CMD /lab.sh

# To use Jupyter Lab, run the following from the host:
#
#	docker run --rm -p8888:8888 -it chanchikwan/hops-lab
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
