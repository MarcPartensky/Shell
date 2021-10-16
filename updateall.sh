#!/bin/sh

ssh vps eval "$(yes | update)"
ssh tower eval "$(yes | update)"
ssh gigabix eval "$(yes | update)"
ssh idefix eval "$(yes | update)"
ssh pandemix eval "$(yes | update)"
ssh memorix eval "$(yes | update)"
ssh boulimix eval "$(yes | update)"
ssh phoenix eval "$(yes | update)"
ssh phoenix-staging eval "$(yes | update)"
ssh edgix eval "$(yes | update)"
