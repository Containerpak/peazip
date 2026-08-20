FROM ubuntu:26.04 AS source

ADD --checksum=sha256:11af7ca6fd633566eb8de969b43ca257b8bce759421775c8c7bbb66105406e58 \
    https://github.com/peazip/PeaZip/releases/download/11.2.0/peazip_11.2.0.LINUX.Qt6-1_amd64.deb \
    /tmp/peazip.deb

FROM ghcr.io/containerpak/mesa64:main

RUN --mount=type=bind,from=source,source=/tmp/peazip.deb,target=/run/peazip.deb \
    apt update && \
    apt install -y --no-install-recommends /run/peazip.deb && \
    cpak-clean-junk
