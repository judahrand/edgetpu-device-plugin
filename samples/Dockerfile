FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install --yes \
        ca-certificates \
        curl \
        git \
        gnupg2

RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install --yes \
        libedgetpu1-std \
        python3-pycoral \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

RUN mkdir coral \
    && cd coral \
    && git clone https://github.com/google-coral/pycoral.git \
    && cd pycoral \
    && examples/install_requirements.sh

WORKDIR /coral/pycoral

ENTRYPOINT ["python3"]

CMD ["--version"]
