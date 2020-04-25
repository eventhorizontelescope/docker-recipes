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
ARG	eattag=0cb085aa
ARG	ehtimtag=491dd805
ARG	ehtplottag=7a056749

FROM	astcon/hops:${srctag}

RUN	laniapt time liblist-moreutils-perl parallel

ARG	ehtplottag
RUN	pip install https://github.com/liamedeiros/ehtplot/archive/${ehtplottag}.tar.gz
ARG	ehtimtag
RUN	pip install https://github.com/achael/eht-imaging/archive/${ehtimtag}.tar.gz
ARG	eattag
RUN	pip install https://github.com/sao-eht/eat/archive/${eattag}.tar.gz
