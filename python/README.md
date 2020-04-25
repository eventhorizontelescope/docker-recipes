# `python`

This Dockerfile builds the [Event Horizon Telescope
(EHT)](https://eventhorizontelescope.org/)'s legacy `python2`
environment for performing data calibration for its observations.

Because this Docker image is based on AstroContainers, which use
Project Laniakea, one can simply run this `python` Docker image as a
Laniakea subcommand.
That is,

    l6a python [args]

Details on using AstroContainers and Laniakea images can be found in
https://astrocontainers.org/ and https://l6a.org, respectively.

## Releases

`python` tags | `lanibase` tag
--- | ---
`2.7`, `20200130`, `2`, `latest` | `20200130`

In general, although a Docker image is immutable, building a new image
is not, even with the same Dockerfile.
Nevertheless, by following Project Laniakea's best practices and using
the Laniakea base image, building an python container using this
Dockerfile should be reproducible.
Non-reproducibility is considered a bug in Project Laniakea, please
report non-reproducibility issues to the maintainer.
