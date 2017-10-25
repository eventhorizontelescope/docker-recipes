# This Dockfiler install jupyter notebook on top the Event Horizon
# Telescope Analysis Toolkit (EAT) for performing data calibration for
# the Event Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The EAT Notebook image
FROM	eventhorizontelescope/eat

# Install Jupyter and other visualization packages
RUN	pip install jupyter ipywidgets &&\
	jupyter nbextension enable --py --sys-prefix widgetsnbextension

# By default we start a Jupyter Notebook
ADD	notebook.sh /
CMD	/notebook.sh

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it eventhorizontelescope/hops-notebook
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
