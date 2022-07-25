FROM hub.c.163.com/library/golang:1.8

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
