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
FROM chanchikwan/hops-stack

# Install Jupyter
RUN apt-get update && apt-get install -y \
		jupyter-notebook jupyter-core \
		jupyter-nbextension-jupyter-js-widgets python-ipykernel \
		python-ipywidgets &&\
	rm -rf /var/lib/apt/lists/*

# By default we start a Jupyter Notebook
CMD ["jupyter-notebook", "--ip=0.0.0.0", "--no-browser"]

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it chanchikwan/hops-stack
#
# then use a browser to open "http://localhost:8888"
