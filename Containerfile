FROM ubuntu:26.04 AS source

ADD --checksum=sha256:20e7a86622213264d4b398d2872ce14133973c2cfaf7bd21e79f764c550be9f8 \
    https://github.com/peazip/PeaZip/releases/download/11.1.0/peazip_11.1.0.LINUX.Qt6-1_amd64.deb \
    /tmp/peazip.deb

FROM ghcr.io/containerpak/mesa:main

COPY --from=source /tmp/peazip.deb /tmp/peazip.deb

RUN apt update && \
    apt install -y --no-install-recommends /tmp/peazip.deb && \
    rm /tmp/peazip.deb && \
    cpak-clean-junk
