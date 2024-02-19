FROM docker.io/pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime
LABEL Description="This image is used to build DiffBIR for Linux" Vendor="n/a" Version="0.3"

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get -qq update && apt-get install -y \
    git \
    libglib2.0-0 \
    libgl1

RUN git clone --recursive https://github.com/XPixelGroup/DiffBIR.git /DiffBIR
WORKDIR /DiffBIR
RUN git checkout 7bd5675823c157b9afdd479b59a2bf0a8954ce11

RUN pip install \
    pytorch-lightning==1.8.6 \
    torchmetrics==1.3.1 \
    xformers==0.0.16 \
    einops \
    open-clip-torch \
    omegaconf \
    triton==2.0.0 \
    opencv-python-headless \
    scipy \
    matplotlib \
    lpips \
    gradio \
    chardet \
    transformers \
    facexlib

# Clean up to reduce image size
RUN apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

# Set an entrypoint
COPY entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]
