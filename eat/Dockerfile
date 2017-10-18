# This Dockfiler builds the Event Horizon Telescope Analysis Toolkit
# (EAT) environment for performing data calibration for the Event
# Horizon Telescope (EHT)'s April 2017 observations.
#
# NOTE: Although a Docker image is immutable, building a new image is
# not, even when the same Dockfile is used.  Hence, the resulting
# images of `docker build .` may be different at different time.
#
#==============================================================================
# The EAT image
FROM	chanchikwan/hops

# Setup runtime environment
RUN	apt-get -qq update &&\
	apt-get install --no-install-recommends -y \
		libsm6 libxext-dev libxrender1 libav-tools \
		liblist-moreutils-perl \
		emacs vim git unzip inkscape pandoc gv parallel \
		python-dev python-pip python-ipython \
		python-subprocess32 python-tk python-ephem \
		texlive-latex-base texlive-latex-extra \
		texlive-xetex texlive-generic-recommended lmodern \
		texlive-fonts-recommended texlive-fonts-extra &&\
 	apt-get remove -y python-backports-shutil-get-terminal-size &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
	pip install --upgrade pip &&\
	pip install wheel setuptools &&\
	pip install future ipython

# Get popular data science software
RUN	pip install cython scipy sympy numexpr astropy
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
