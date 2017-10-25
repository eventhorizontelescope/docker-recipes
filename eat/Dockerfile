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
FROM	chanchikwan/hops AS hops

#==============================================================================
# The EAT image
FROM	chanchikwan/aips

# Setup runtime environment
RUN	apt-get -qq update
RUN	apt-get install --no-install-recommends -y \
		libgfortran3 libquadmath0 libfftw3-double3 zlib1g libx11-6 \
		libsm6 libxext-dev libxrender1 libav-tools \
		liblist-moreutils-perl \
		csh ghostscript-x less perl-doc gcc \
		emacs vim git unzip inkscape pandoc gv parallel \
		python-dev python-pip ipython cython \
		python-subprocess32 python-tk python-ephem \
		python-scipy python-sympy \
		texlive-latex-base texlive-latex-extra \
		texlive-xetex texlive-generic-recommended lmodern \
		texlive-fonts-recommended texlive-fonts-extra &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip install --upgrade pip &&\
	pip install wheel setuptools &&\
	pip install future tqdm

# Copy HOPS from the hops image
COPY	--from=hops /usr/local/hops /usr/local/hops
RUN	printf '\n# all users should source HOPS\n\
if [ -f /usr/local/hops/bin/hops.bash ]; then\n\
  source /usr/local/hops/bin/hops.bash\n\
  unset HOPS_ARCH\n\
  export LD_LIBRARY_PATH="/usr/local/hops/lib/hops:$LD_LIBRARY_PATH"\n\
fi\n' >> /etc/bash.bashrc

# Get popular data science software
RUN	pip install numexpr astropy
RUN	pip install pandas scikit-learn scikit-image
RUN	pip install matplotlib seaborn bokeh holoviews

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
	printf '\n# prepend the hopstool path to $PATH\n\
export PATH="/usr/local/src/hopstools:$PATH"\n\
' >> /etc/bash.bashrc

# Clone eht-imaging source and make it available
RUN	cd /usr/local/src &&\
	git clone https://github.com/achael/eht-imaging.git ehtim &&\
	cd ehtim &&\
	pip install -e .

# Clone ehtplot source and install it in development mode
RUN	cd /usr/local/src &&\
	git clone https://github.com/liamedeiros/ehtplot.git &&\
	cd ehtplot &&\
	pip install -e .
