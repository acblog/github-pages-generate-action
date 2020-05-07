#!/bin/sh
set -e

INPUT_DOMAIN=${INPUT_DOMAIN:-'/'}
INPUT_APP=${INPUT_APP:-'./app'}
INPUT_DIST=${INPUT_DIST:-'./dist'}

docker pull acblog/wasm:latest
container=$(docker run -d acblog/wasm:latest)
docker stop $container
docker cp $container:/app $INPUT_DIST
docker rm $container
cp -r $INPUT_APP/* $INPUT_DIST
echo "* binary" > $INPUT_DIST/.gitattributes
echo "" > $INPUT_DIST/.nojekyll
$(cat $INPUT_DIST/404.html) -replace "<base href=""/"" />", "<base href=""$INPUT_DOMAIN"" />" > $INPUT_DIST/404.html
$(cat $INPUT_DIST/index.html) -replace "<base href=""/"" />", "<base href=""$INPUT_DOMAIN"" />" > $INPUT_DIST/index.html
