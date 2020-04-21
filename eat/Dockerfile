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

FROM	astcon/hops:${srctag}

RUN	laniapt	python3-setuptools python3-pip python3-wheel python3-future \
		python3-tk python3-pynfft python3-tables python3-pandas \
		python3-scipy python3-h5py python3-ephem python3-astropy \
		python3-matplotlib python3-seaborn \
		python3-skimage python3-sklearn ipython3
RUN	laniapt time liblist-moreutils-perl parallel
RUN	laniapt jupyter-notebook jupyter-nbconvert
COPY	notebook /usr/local/bin/

RUN	pip3 install https://github.com/liamedeiros/ehtplot/archive/0.9.0.tar.gz
RUN	pip3 install https://github.com/achael/eht-imaging/archive/v1.1.2.tar.gz
RUN	pip3 install https://github.com/sao-eht/eat/archive/v1.6.tar.gz

CMD	["ipython3"]

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat notebook
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
