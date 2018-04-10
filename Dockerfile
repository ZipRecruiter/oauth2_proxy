FROM 075448606089.dkr.ecr.us-east-1.amazonaws.com/base/build-golang:1.10-alpine3.7 AS build

RUN apk add --update --no-cache git
ENV GOPROJ=github.com/bitly/oauth2_proxy
RUN mkdir -p $GOPATH/src/$GOPROJ
WORKDIR $GOPATH/src/$GOPROJ
COPY . .
RUN go get ./...
RUN go install ./...

FROM 075448606089.dkr.ecr.us-east-1.amazonaws.com/base/alpine:3.7
RUN apk add --update --no-cache ca-certificates
COPY --from=build /go/bin/oauth2_proxy /oauth2_proxy
ENTRYPOINT ["/oauth2_proxy"]
