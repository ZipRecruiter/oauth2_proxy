FROM 075448606089.dkr.ecr.us-east-1.amazonaws.com/base/build-golang:1.10-alpine3.7 AS build

RUN apk add --update --no-cache git
RUN go-wrapper download github.com/bitly/oauth2_proxy
RUN go-wrapper install github.com/bitly/oauth2_proxy

FROM 075448606089.dkr.ecr.us-east-1.amazonaws.com/base/alpine:3.7
RUN apk add --update --no-cache ca-certificates
COPY --from=build /go/bin/oauth2_proxy /oauth2_proxy
ENTRYPOINT ["/oauth2_proxy"]
