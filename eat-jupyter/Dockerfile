# Copyright 2017,2020 Chi-kwan Chan
# Copyright 2017 Center for Astrophysics | Harvard & Smithsonian
# Copyright 2020 Steward Observatory
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You
# may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.

ARG	dsttag=3.20
ARG	srctag=20200130

# This Dockfiler install jupyter notebook on top the Event Horizon
# Telescope Analysis Toolkit (EAT) for performing data calibration for
# the Event Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.

# The base image is EHT's EAT image
FROM	ehtcon/eat:${srctag}

# Install Jupyter and other visualization packages
RUN	laniapt jupyter-notebook jupyter-nbconvert

# By default we start a Jupyter Notebook
ADD	notebook.sh /
CMD	/notebook.sh

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat-jupyter
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
