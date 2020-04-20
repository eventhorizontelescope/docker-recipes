#!/usr/bin/env bash
#
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

source /usr/local/hops/*/bin/hops.bash

if [ -f .jupyter/jupyter_notebook_config.py ]; then
	jupyter-notebook
else
	jupyter-notebook --allow-root --ip='0.0.0.0' --no-browser
fi
