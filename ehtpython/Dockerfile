# Copyright 2020 Chi-kwan Chan
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

ARG	dsttag=1.6,20200130,1,latest
ARG	srctag=20200130

FROM	astcon/astropy:${srctag} AS base

# Generic science python packages
RUN	laniapt	python-more-itertools python-pyfftw python-pynfft \
		python-pandas python-tables python-h5py python-scipy \
		python-seaborn python-skimage python-sklearn

# Jupyter notebook
RUN	laniapt python-ipaddress \
		python-jupyter-core python-jupyter-client python-jupyter-console \
		python-ipykernel python-notebook python-nbformat python-nbconvert
COPY	jupyter notebook /usr/local/bin/
RUN	ln -s jupyter /usr/local/bin/jupyter-notebook &&\
	ln -s jupyter /usr/local/bin/jupyter-console  &&\
	ln -s jupyter /usr/local/bin/jupyter-nbconvert

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat notebook
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
