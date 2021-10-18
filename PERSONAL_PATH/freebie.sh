#!/bin/env sh

pushd .

cd ~/Games/epicgames-freebies-claimer
git pull
echo "==============$(date)============" >> freebies.log
echo "==============$(date)============" >> freebies.err.log
npm start 1>> freebies.log 2>> freebies.err.log

echo Log
cat ./freebies.log
echo ErrLog
cat ./freebies.err.log

popd
