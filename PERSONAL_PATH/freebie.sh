#!/bin/env sh

pushd .

cd ~/Games/epicgames-freebies-claimer
npm start 1> freebies.log 2> freebies.err.log

echo Log
cat ./freebies.log
echo ErrLog
cat ./freebies.err.log

popd
