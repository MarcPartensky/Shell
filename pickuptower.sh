#!/bin/sh

ssh -NL 9200:localhost:9200 tower &
ssh -NL 27017:localhost:27017 tower &
ssh -NL 5672:localhost:5672 tower &
ssh -NL 15672:localhost:15672 tower &
ssh -NL 21:localhost:21 tower &
ssh -NL 5601:localhost:5601 tower &
