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

FROM	ehtcon/eat:${srctag}

RUN	laniapt jupyter-notebook jupyter-nbconvert
COPY	notebook /usr/local/bin/

CMD	["notebook"]

# To use Jupyter Notebook, run the following from the host:
#
#	docker run --rm -p8888:8888 -it ehtcon/eat-jupyter
#
# then use a browser to open
#
#	http://[localhost or ip of remote machine]:8888?token=1234...
