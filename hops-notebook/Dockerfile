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

# Always start a Jupyter Notebook
ENTRYPOINT ["jupyter-notebook", "--ip=0.0.0.0", "--no-browser"]
