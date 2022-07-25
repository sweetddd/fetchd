FROM registry.cn-beijing.aliyuncs.com/pox/dna-chain-test:SNAPSHOT-64

WORKDIR /apps
COPY . .
RUN cargo build --release
RUN git config --global url."https://github.powx.io/".insteadOf https://github.com/

RUN  apt install apt-transport-https ca-certificates

RUN cp sources.list /etc/apt/sources.list

RUN  apt-get update
RUN  apt-get install nginx -y


#RUN ./target/release/dtx-chain build-spec --disable-default-bootnode --chain local > customSpec.json
#RUN ./target/release/dtx-chain build-spec --chain=customSpec.json --raw --disable-default-bootnode > config/customSpecRaw.json
COPY nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 9900
