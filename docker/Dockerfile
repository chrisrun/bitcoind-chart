FROM buildpack-deps:buster-curl as builder

# This buildarg can be set during container build time with --build-arg VERSION=[version]
ARG VERSION=24.0.1

RUN apt-get update && \
  apt-get install -y gnupg2 curl && \
  rm -rf /var/lib/apt/lists/*

COPY ./get-bitcoin.sh /usr/bin/
RUN chmod +x /usr/bin/get-bitcoin.sh && \
  mkdir /root/bitcoin && \
  get-bitcoin.sh $VERSION /root/bitcoin/

FROM debian:buster-slim

# These buildargs can be set during container build time with --build-arg UID=[uid]
ARG UID=1000
ARG GID=1000
ARG USERNAME=bitcoin

RUN apt-get update && \
  apt-get install -y iproute2 sudo && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g $GID -o $USERNAME && \
  useradd -m -u $UID -g $GID -o -d /home/$USERNAME -s /bin/bash $USERNAME

COPY --from=builder /root/bitcoin/ /usr/local/
COPY ./entrypoint.sh /usr/local/entrypoint.sh
RUN chmod a+rx /usr/local/entrypoint.sh && \
  mkdir -p /bitcoin/data && \
  chown -R $USERNAME:$GID /bitcoin

USER $USERNAME

EXPOSE 8332 8333 18332 18333 28332 28333

ENTRYPOINT ["/usr/local/entrypoint.sh"]
