#!/bin/sh
if [ -z "${TRAVIS_TAG}" ] || [ "${TRAVIS_PULL_REQUEST}" = "true" ]
  then
    echo "Skipping the Excelsior Jet build."
    return
fi
if [ -n "${JET_URL}" ] || [ "${TRAVIS_PULL_REQUEST}" = "true" ]
  then
    echo "Unknown JET_URL variable, skipping build."
    return
fi

wget -q --no-check-certificate -O jet-1130-pro-en-linux-x86.bin "${JET_URL}"
chmod +x ./jet-1130-pro-en-linux-x86.bin
./jet-1130-pro-en-linux-x86.bin -batch -no-aftrun
mvn "-Djet.home=`pwd`/jet11.3-pro-x86/" jet:testrun jet:build
