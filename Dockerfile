FROM ubuntu:18.04
MAINTAINER muabnesor <adam.rosenbaum@umu.se>

LABEL description="Image for SAMTOOLS 1.9"

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    build-essential \
    libncurses5-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl3-dev && \
    apt-get clean && apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# samtools 
ENV SAMTOOLS_VERSION 1.9
ENV HTSLIB_VERSION 1.9
WORKDIR /usr/src

RUN wget https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 && \
    tar -vxjf htslib-${HTSLIB_VERSION}.tar.bz2 && \
    cd htslib-${HTSLIB_VERSION} && \
    ./configure && make

WORKDIR /usr/src

RUN wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    tar -vxjf samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    cd samtools-${SAMTOOLS_VERSION} && \
    ./configure && make

WORKDIR /usr/src

ENV PATH ${PATH}:/usr/src/samtools-${SAMTOOLS_VERSION}:/usr/src/samtools-${HTSLIB_VERSION}

# Set default working path
WORKDIR /usr/src
