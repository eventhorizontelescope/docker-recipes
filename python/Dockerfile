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

FROM	l6acon/lanibase:${srctag} AS base

# Generic science python packages
RUN	laniapt	python-setuptools python-pip python-wheel \
		python-future python-py python-pytest \
		python-more-itertools python-pyfftw python-pynfft \
		python-tables python-pandas python-h5py python-scipy \
		python-tk python-matplotlib python-seaborn \
		python-skimage python-sklearn

# Astronomy python packages
RUN	laniapt python-attr python-pluggy python-atomicwrites python-ephem
RUN	pip install astropy==2.0.16

# ipython
RUN	laniapt ipython

# Jupyter notebook
RUN	laniapt jupyter-notebook jupyter-nbconvert
COPY	notebook /usr/local/bin/

CMD	["ipython"]

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat notebook
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
