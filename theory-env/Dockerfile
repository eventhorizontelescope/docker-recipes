# Copyright 2021 Chi-kwan Chan
# Copyright 2021 Steward Observatory
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

ARG	dsttag=latest
ARG	srctag=20201117

FROM	ehtcon/ehtpython:${srctag} AS base

RUN	laniapt	python3-joblib python3-ruamel.yaml
RUN	pip3 install https://github.com/rndsrc/ehtim/archive/master.zip
