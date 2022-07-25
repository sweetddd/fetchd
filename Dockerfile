FROM hub.c.163.com/library/golang:1.8

ENV PACKAGES jq curl wget jq file make git
RUN cp sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y jq curl wget jq file make git

WORKDIR /apps
COPY . .
RUN ls -a
RUN go version
RUN #make build
RUN make install
RUN  apt-get install nginx -y
RUN sh init.sh

#RUN ./target/release/dtx-chain build-spec --disable-default-bootnode --chain local > customSpec.json
#RUN ./target/release/dtx-chain build-spec --chain=customSpec.json --raw --disable-default-bootnode > config/customSpecRaw.json
#COPY nginx/nginx.conf /etc/nginx/nginx.conf
#EXPOSE 9900
