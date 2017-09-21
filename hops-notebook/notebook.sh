#!/usr/bin/env bash

if [ -f .jupyter/jupyter.pem  -a -f .jupyter/jupyter.key ]; then
	FLAGS="--certfile=.jupyter/jupyter.pem --keyfile=.jupyter/jupyter.key"
fi

jupyter-notebook $FLAGS --allow-root --ip='*' --no-browser
