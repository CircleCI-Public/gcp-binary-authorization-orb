#!/bin/bash

circleci config pack src > orb.yml
circleci orb publish orb.yml circleci/gcp-binary-authorization@dev:alpha
rm -rf orb.yml
