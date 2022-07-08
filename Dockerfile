FROM ruby:3.1

ENV NODE_VERSION 15.0.1

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
&& case "${dpkgArch##*-}" in \
amd64) ARCH='x64';; \
ppc64el) ARCH='ppc64le';; \
s390x) ARCH='s390x';; \
arm64) ARCH='arm64';; \
armhf) ARCH='armv7l';; \
i386) ARCH='x86';; \
*) echo "unsupported architecture"; exit 1 ;; \
esac \
&& set -ex \
&& curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
&& tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
&& rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
&& ln -s /usr/local/bin/node /usr/local/bin/nodejs \
&& node --version \
&& npm --version

# RUN apt-get update && apt-get install -y yarn \
# && yarn --version

RUN mkdir /pai-log
WORKDIR /pai-log
COPY Gemfile /pai-log/Gemfile
COPY Gemfile.lock /pai-log/Gemfile.lock
RUN bundle install
COPY . /pai-log

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
