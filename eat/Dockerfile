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

ARG	dsttag=20200130
ARG	srctag=20200130

# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The base image: the AstroContainers HOPS image

FROM	astcon/hops:${srctag} AS base

#==============================================================================
# The EAT runtime image

# Setup runtime environment
RUN	laniapt	python3-setuptools python3-pip python3-wheel python3-future \
		python3-tk python3-pynfft python3-tables python3-pandas \
		python3-scipy python3-h5py python3-ephem python3-astropy \
		python3-matplotlib python3-seaborn \
		python3-skimage python3-sklearn ipython3
RUN	laniapt time liblist-moreutils-perl parallel

# Install EAT stack using zip files directly from GitHub
RUN	pip3 install https://github.com/liamedeiros/ehtplot/archive/master.zip
RUN	pip3 install https://github.com/achael/eht-imaging/archive/master.zip
RUN	pip3 install https://github.com/sao-eht/eat/archive/master.zip
