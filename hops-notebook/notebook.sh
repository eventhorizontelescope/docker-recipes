#!/usr/bin/env bash

. /usr/local/hops/bin/hops.bash
HOPS_ARCH='.'
HOPS_ROOT='/usr/local/hops'

if [ -f .jupyter/jupyter_notebook_config.py ]; then
	jupyter-notebook
else
	jupyter-notebook --allow-root --ip='*' --no-browser
fi
