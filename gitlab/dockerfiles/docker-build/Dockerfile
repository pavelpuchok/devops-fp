FROM docker:18.09.7
RUN apk add --no-cache make=4.2.1-r2 python3=3.7.3-r0

# install terraform
RUN wget -O /tmp/tf.zip https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip && \
        unzip /tmp/tf.zip -d /usr/bin && \
        rm /tmp/tf.zip
