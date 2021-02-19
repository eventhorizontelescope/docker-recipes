# `theory-env`

This Dockerfile builds the [Event Horizon Telescope
(EHT)](https://eventhorizontelescope.org/)'s `python`
environment/platform for performing data calibration for its
observations.

Because EHT Containers are based on AstroContainers, which is based on
Project Laniakea, one can simply run this Docker image as a Laniakea
subcommand.
That is,

    l6a theory-env [args]

Details on running AstroContainers images can be found in
https://astrocontainers.org/.

## Releases

`ehtcon/theory-env` tags | `ehtcon/ehtpython` tag
--- | ---
`latest` | `20201117`

In general, although a Docker image is immutable, building a new image
is not even when using the same Dockerfile.
Nevertheless, by following Project Laniakea's best practices and using
the Laniakea base image, building image with this Dockerfile should be
reproducible.
Non-reproducibility is considered a bug in Project Laniakea, please
report non-reproducibility issues to the maintainer.
