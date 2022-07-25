FROM golang:1.18
ENV PACKAGES jq curl wget jq file make git


WORKDIR /apps
COPY . .
#RUN apt-get update
#RUN  apt install -y apt-transport-https ca-certificates
#RUN cp sources.list /etc/apt/sources.list

#RUN apt-get install -y  curl   make git
RUN ls -a
RUN go version
RUN go env -w GOPROXY=https://goproxy.cn,direct
#RUN go mod tidy
RUN make install
RUN  #apt-get install nginx -y
RUN sh init.sh

#RUN ./target/release/dtx-chain build-spec --disable-default-bootnode --chain local > customSpec.json
#RUN ./target/release/dtx-chain build-spec --chain=customSpec.json --raw --disable-default-bootnode > config/customSpecRaw.json
#COPY nginx/nginx.conf /etc/nginx/nginx.conf
#EXPOSE 9900
