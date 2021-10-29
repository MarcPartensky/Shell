#!/bin/sh

ssh -NL 0.0.0.0:9200:localhost:9200 tower &
ssh -NL 0.0.0.0:27017:localhost:27017 tower &
ssh -NL 0.0.0.0:5672:localhost:5672 tower &
ssh -NL 0.0.0.0:15672:localhost:15672 tower &
ssh -NL 0.0.0.0:21:localhost:21 tower &
ssh -NL 0.0.0.0:5601:localhost:5601 tower &
ssh -NL 0.0.0.0:30000:localhost:30000 tower &
ssh -NL 0.0.0.0:30001:localhost:30001 tower &
ssh -NL 0.0.0.0:30002:localhost:30002 tower &
ssh -NL 0.0.0.0:30003:localhost:30003 tower &
ssh -NL 0.0.0.0:30004:localhost:30004 tower &
ssh -NL 0.0.0.0:30005:localhost:30005 tower &
ssh -NL 0.0.0.0:30006:localhost:30006 tower &
ssh -NL 0.0.0.0:30007:localhost:30007 tower &
ssh -NL 0.0.0.0:30008:localhost:30008 tower &
ssh -NL 0.0.0.0:30009:localhost:30009 tower &
