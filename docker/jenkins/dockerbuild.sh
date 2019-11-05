#!/bin/bash
echo "$(basename $0) start!"
docker build -t jenkins-master:latest .
echo "$(basename $0) done!"
exit 0

