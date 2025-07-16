FROM ubuntu:20.04 as base-fetch
RUN apt-get update && apt-get install -y git

FROM ubuntu:20.04 as base-build
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y build-essential pkg-config tzdata

FROM base-fetch as fetch-quiche
WORKDIR /root
RUN git clone --recursive --depth 1 https://github.com/cloudflare/quiche

FROM base-build as build-quiche
WORKDIR /root

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    curl cmake tzdata git clang llvm-dev libclang-dev pkg-config

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

COPY --from=fetch-quiche /root/quiche /root/quiche
WORKDIR /root/quiche/
RUN git submodule update --init --recursive

RUN ~/.cargo/bin/cargo build --release --features ffi,pkg-config-meta,qlog \
  && mkdir -p quiche/deps/boringssl/src/lib \
  && find target/release -name "libcrypto.a" -exec ln -vnf {} quiche/deps/boringssl/src/lib/ \; \
  && find target/release -name "libssl.a" -exec ln -vnf {} quiche/deps/boringssl/src/lib/ \;


FROM base-fetch as fetch-curl
WORKDIR /root
COPY http3-flood.sh /root/http3-flood.sh
RUN touch /root/sslkeylog.log
RUN git clone --depth 1 https://github.com/curl/curl

FROM base-build as build-curl
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    autoconf libtool pkg-config \
    libpsl-dev  # <-- Install libpsl-dev here to fix the missing libpsl dependency
COPY --from=fetch-curl /root/curl /root/curl
WORKDIR /root/curl
RUN ./buildconf
COPY --from=build-quiche /root/quiche /root/quiche
RUN ./configure LDFLAGS="-Wl,-rpath,$PWD/../quiche/target/release" \
  --with-openssl=$PWD/../quiche/quiche/deps/boringssl/src \
  --with-quiche=$PWD/../quiche/target/release \
  --with-ca-path=/etc/ssl/certs
RUN make -j`nproc`
RUN make install


FROM ubuntu:20.04 as executor

ENV TMPDIR=/var/tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    tcpdump \
    bash \
    libpsl5 \
 && rm -rf /var/lib/apt/lists/*

# Copy shared libraries and binaries
COPY --from=build-curl /usr/local/lib/libcurl.so.4 /usr/local/lib/libcurl.so.4
COPY --from=build-curl /root/quiche/target/release/libquiche.so /usr/local/lib/libquiche.so
COPY --from=build-curl /usr/local/bin/curl /usr/local/bin/curl

# Make sure system knows about the libraries
RUN ldconfig

# Copy the attack script
COPY --from=fetch-curl /root/http3-flood.sh /root/http3-flood.sh
RUN chmod +x /root/http3-flood.sh

CMD ["bash"]

