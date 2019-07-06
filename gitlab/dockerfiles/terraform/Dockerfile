FROM alpine:3.10

# Download and unpack terraform
RUN wget -O /tmp/tf.zip https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip && \
        unzip /tmp/tf.zip -d /usr/bin && \
        rm /tmp/tf.zip

ENTRYPOINT [ "terraform" ]
