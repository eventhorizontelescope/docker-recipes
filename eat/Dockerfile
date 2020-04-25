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

ARG	dsttag=1.6,20200130,1,latest
ARG	srctag=20200130
ARG	hopstag=20200130
ARG	eattag=0cb085aa
ARG	ehtimtag=491dd805
ARG	ehtplottag=7a056749

#==============================================================================
# The base image: the EHT python2 environment/platform

FROM	ehtcon/ehtpython:${srctag} AS base

RUN	sed -n 's/^deb \(.*\) buster main$/deb \1 jessie main non-free/p' \
		/etc/apt/sources.list > /etc/apt/sources.list.d/jessie.list
COPY	jessie.pref /etc/apt/preferences.d/

RUN	laniapt	libgfortran5 libquadmath0 ghostscript-x \
		libfftw3-double3 zlib1g libx11-6 libpng12-0 pgplot5 \
		csh less
RUN	laniapt time liblist-moreutils-perl parallel

#==============================================================================
# The HOPS image

ARG	hopstag
FROM	astcon/hops:${hopstag} AS builder

#==============================================================================
# The EAT runtime image

FROM	base

# Copy HOPS from the builder image
COPY	--from=builder /usr/local/hops /usr/local/hops
COPY	entrypoint /usr/local/sbin/

ARG	ehtplottag
RUN	pip install https://github.com/liamedeiros/ehtplot/archive/${ehtplottag}.tar.gz
ARG	ehtimtag
RUN	pip install https://github.com/achael/eht-imaging/archive/${ehtimtag}.tar.gz
ARG	eattag
RUN	pip install https://github.com/sao-eht/eat/archive/${eattag}.tar.gz
