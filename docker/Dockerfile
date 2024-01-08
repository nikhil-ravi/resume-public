# This Dockerfile is used to build a Docker image for generating a resume.
# It starts with the base Ubuntu image and installs the necessary dependencies.
# The image includes pandoc and make for document conversion and texlive-xetex for PDF generation.
# It also copies custom fonts into the container and updates the font cache.

FROM ubuntu

LABEL maintainer="muggle7 <email@bla.com>"

RUN apt-get update && apt-get install -y make git wget gh
RUN wget https://github.com/jgm/pandoc/releases/download/3.1.11.1/pandoc-3.1.11.1-1-amd64.deb \
    && dpkg -i pandoc-3.1.11.1-1-amd64.deb \
    && rm pandoc-3.1.11.1-1-amd64.deb
RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y texlive-xetex \
    && rm -rf /var/lib/apt/lists/*