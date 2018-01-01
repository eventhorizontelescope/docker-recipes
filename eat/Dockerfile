# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The HOPS image
FROM	eventhorizontelescope/hops AS hops

#==============================================================================
# The EAT image
FROM	eventhorizontelescope/aips

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		libgfortran3 libquadmath0 libfftw3-double3 zlib1g libx11-6 \
		libxext-dev libxrender1 libav-tools liblist-moreutils-perl \
		libsm6 \
		gcc csh ghostscript-x less perl-doc \
		emacs vim git unzip inkscape pandoc gv parallel \
		texlive-latex-base texlive-latex-extra \
		texlive-xetex texlive-generic-recommended lmodern \
		texlive-fonts-recommended texlive-fonts-extra \
		cython ipython \
		python-zmq python-tk python-ephem \
		python-tornado python-markupsafe \
		python-wheel python-setuptools python-future python-pip \
		python-numexpr python-pandas python-scipy python-sympy \
		python-astropy python-sklearn-lib python-skimage-lib \
		python-matplotlib python-seaborn \
		cython3 ipython3 \
		python3-zmq python3-tk python3-ephem \
		python3-tornado python3-markupsafe \
		python3-wheel python3-setuptools python3-future python3-pip \
		python3-numexpr python3-pandas python3-scipy python3-sympy \
		python3-astropy python3-sklearn-lib python3-skimage-lib \
		python3-matplotlib python3-seaborn &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip2 install --upgrade pip pandas &&\
	pip2 install tqdm bokeh holoviews &&\
	pip3 install --upgrade pip pandas &&\
	pip3 install tqdm bokeh holoviews

# Copy HOPS from the hops image
COPY	--from=hops /usr/local/hops /usr/local/hops
RUN	printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  source /usr/local/hops/bin/hops.bash\n\
  unset HOPS_ARCH\n\
  export LD_LIBRARY_PATH="/usr/local/hops/lib/hops:$LD_LIBRARY_PATH"\n\
fi\n' >> /etc/bash.bashrc

# Clone EAT source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/sao-eht/eat.git &&\
	cd eat &&\
	pip2 install -e . &&\
	pip3 install -e . &&\
	printf '\n# prepend the EAT script path to $PATH\n\
export PATH="/usr/local/src/eat/bin:$PATH"\n\
' >> /etc/bash.bashrc

# Clone hopstools source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/klbouman/hopstools.git &&\
	printf '\n# prepend the hopstool path to $PATH\n\
export PATH="/usr/local/src/hopstools:$PATH"\n\
' >> /etc/bash.bashrc

# Clone eht-imaging source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/achael/eht-imaging.git ehtim &&\
	cd ehtim &&\
	pip2 install -e . &&\
	pip3 install -e .

# Clone ehtplot source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/liamedeiros/ehtplot.git &&\
	cd ehtplot &&\
	pip2 install -e . &&\
	pip3 install -e .

# Switch back the work directory
WORKDIR /root
