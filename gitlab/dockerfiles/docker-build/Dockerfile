FROM docker:18.09.7
RUN apk add --no-cache \
        make=4.2.1-r2 \
        python3=3.7.3-r0 \
        python3-dev=3.7.3-r0 \
        python2=2.7.16-r1 \
        gcc=8.3.0-r0 \
        musl-dev=1.1.22-r2 \
        libffi-dev=3.2.1-r6 \
        openssl-dev=1.1.1c-r0

ARG TF_URL=https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip
ARG CLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-253.0.0-linux-x86_64.tar.gz

# install terraform, GCloud SDK
RUN wget -O /tmp/tf.zip "$TF_URL" && \
        unzip /tmp/tf.zip -d /usr/bin && \
        rm /tmp/tf.zip && \
        wget -O /tmp/google-sdk.tar.gz "$CLOUD_SDK_URL" && \
        tar -xvf /tmp/google-sdk.tar.gz && \
        rm /tmp/google-sdk.tar.gz && \
        ./google-cloud-sdk/install.sh --quiet && \
        ln -s /google-cloud-sdk/bin/gcloud /usr/bin/gcloud

