#!/bin/pwsh

docker pull acblog/wasm:latest
$container=$(docker run -d acblog/wasm:latest)
docker stop $container
docker cp $container:/app $env:INPUT_DIST
docker rm $container
cp -r $env:INPUT_APP/* $env:INPUT_DIST
echo "* binary" > $env:INPUT_DIST/.gitattributes
echo "" > $env:INPUT_DIST/.nojekyll
$(cat $env:INPUT_DIST/404.html) -replace "<base href=""/"" />", "<base href=""$env:INPUT_DOMAIN"" />" > $env:INPUT_DIST/404.html
$(cat $env:INPUT_DIST/404.html) -replace "sparedirectEncode(l, 0)", "sparedirectEncode(l, $env:INPUT_SEGMENTCOUNT)" > $env:INPUT_DIST/404.html
$(cat $env:INPUT_DIST/index.html) -replace "<base href=""/"" />", "<base href=""$env:INPUT_DOMAIN"" />" > $env:INPUT_DIST/index.html
