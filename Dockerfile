# Reference Sources:
# - https://github.com/docker-library/openjdk

# Step 1: Start from the google cloud SDK image:
FROM google/cloud-sdk:alpine

# Step 2: Set some environment variables:
ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre \
    PATH=/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin:$PATH

# Step 3: Set /var/pubsub as a volume:
VOLUME /var/pubsub

# Step 4: Install OpenJDK Java Runtime Environment:
RUN set -x && \
  export JAVA_VERSION=8u201 JAVA_ALPINE_VERSION=8.201.08-r1 && \
  apk add --no-cache openjdk8-jre="$JAVA_ALPINE_VERSION"

# Step 5: Install the pubsub emulator:
RUN set -e && \
  gcloud components install --quiet beta pubsub-emulator && \
  rm -rf /google-cloud-sdk/.install/.backup

# Step 6: Copy the pubsub entrypoint script:
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Step 7: Set the pubsub entrypoint:
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
