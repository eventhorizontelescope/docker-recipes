# [`EAT`][1]

This Dockerfile builds the [Event Horizon Telescope Analysis Toolkit
(`EAT`)](https://github.com/sao-eht/eat) environment for performing
data calibration for the [Event Horizon Telescope
(EHT)](https://eventhorizontelescope.org/)'s observations.

Because EHT Containers are based on AstroContainers, which is based on
Project Laniakea, one can simply run this Docker image as a Laniakea
subcommand.
That is,

    l6a eat [args]

Details on running AstroContainers images can be found in
https://astrocontainers.org/.

## Releases

[`ehtcon/eat`][1] tags | `ehtcon/ehtpython` tag | `astcon/hops` tag | `eat` commit ID | `ehtim` commit ID | `ehtplot` commit ID
--- | --- | --- | --- | --- | ---
`1.6`, `20200130`, `1`, `latest` | `20200130` | `20200130` | `0cb085aa` | `491dd805` | `7a056749`

In general, although a Docker image is immutable, building a new image
is not even when using the same Dockerfile.
Nevertheless, by following Project Laniakea's best practices and using
the Laniakea base image, building image with this Dockerfile should be
reproducible.
Non-reproducibility is considered a bug in Project Laniakea, please
report non-reproducibility issues to the maintainer.

[1]: https://hub.docker.com/repository/docker/ehtcon/eat
