# `python`

This Dockerfile builds the [Event Horizon Telescope
(EHT)](https://eventhorizontelescope.org/)'s legacy `python2`
environment/platform for performing data calibration for its
observations.

Because AstroContainers are based on Project Laniakea, one can simply
run this HOPS Docker image as a Laniakea subcommand.
That is,

    l6a python [args]

Details on running AstroContainers images can be found in
https://astrocontainers.org/.

## Releases

`ehtcon/python` tags | `astcon/astropy` tag
--- | ---
`2.7`, `20200130`, `2`, `latest` | `20200130`

In general, although a Docker image is immutable, building a new image
is not even when using the same Dockerfile.
Nevertheless, by following Project Laniakea's best practices and using
the Laniakea base image, building image with this Dockerfile should be
reproducible.
Non-reproducibility is considered a bug in Project Laniakea, please
report non-reproducibility issues to the maintainer.
