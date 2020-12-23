FROM node:14

# Install packages
RUN apt-get update \
    && \
    # apt Debian packages
    apt-get install -y --no-install-recommends \
        bash \
        git \
  && \
  npm install --global --unsafe-perm \
    expo-cli \
  && \
  npm cache clean --force

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
