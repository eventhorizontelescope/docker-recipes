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
		texlive-fonts-recommended texlive-fonts-extra &&\
	apt-get install --no-install-recommends -y \
		cython ipython python-dev python-setuptools python-pip \
		python-future python-tk python-pynfft \
		python-pandas python-scipy python-astropy python-matplotlib &&\
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip install --upgrade pip pandas scipy
RUN	pip install wheel tqdm zmq ephem markupsafe numexpr sympy \
		scikit-learn scikit-image seaborn bokeh holoviews

# Copy HOPS from the hops image
COPY	--from=hops /usr/local/hops /usr/local/hops
RUN	printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  source /usr/local/hops/bin/hops.bash\n\
  unset HOPS_ARCH\n\
fi\n' >> /etc/bash.bashrc

# Clone EAT source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/sao-eht/eat.git &&\
	cd eat &&\
	pip install -e . &&\
	printf '\n# prepend the EAT script path to $PATH\n\
export PATH="/usr/local/src/eat/bin:$PATH"\n\
' >> /etc/bash.bashrc

# Clone hopstools source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/klbouman/hopstools.git &&\
	chmod 755 hopstools/*.py &&\
	printf '\n# prepend the hopstool path to $PATH\n\
export PATH="/usr/local/src/hopstools:$PATH"\n\
' >> /etc/bash.bashrc

# Clone eht-imaging source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/achael/eht-imaging.git ehtim &&\
	cd ehtim &&\
	pip install -e . &&\
	printf '\n# prepend the ehtim script path to $PATH\n\
export PATH="/usr/local/src/ehtim/scripts:$PATH"\n\
' >> /etc/bash.bashrc

# Clone ehtplot source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/liamedeiros/ehtplot.git &&\
	cd ehtplot &&\
	pip install -e .

# Switch back the work directory
WORKDIR /root
