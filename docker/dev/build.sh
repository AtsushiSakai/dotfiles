#!/bin/bash
echo "$(basename $0) start!"
docker build -t dev .
echo "$(basename $0) done!"
exit 0

