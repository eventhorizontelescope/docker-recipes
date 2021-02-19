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

ARG	dsttag=2.7,20200130,2,latest
ARG	srctag=20200130

FROM	astcon/astropy:${srctag} AS base

# Generic science python packages
RUN	laniapt	python3-more-itertools python3-requests python3-pyfftw python3-pynfft \
		python3-pandas python3-tables python3-h5py python3-scipy \
		python3-seaborn python3-skimage python3-sklearn

# Jupyter notebook
RUN	laniapt python3-jupyter-core python3-jupyter-client python3-jupyter-console \
		python3-ipykernel python3-notebook python3-nbformat python3-nbconvert
COPY	jupyter /usr/local/bin/
RUN	for dst in $(bash -c 'echo {jupyter-,}{notebook,console,nbconvert}'); do \
		ln -s jupyter "/usr/local/bin/$dst"; \
	done

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat notebook
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
