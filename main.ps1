#!/bin/pwsh

docker pull acblog/wasm:latest
if (!$?) {
    exit 1
}
$container=$(docker run -d acblog/wasm:latest)
if (!$?) {
    exit 1
}
docker stop $container
if (!$?) {
    exit 1
}
docker cp ${container}:/app $env:INPUT_DIST
if (!$?) {
    exit 1
}
docker rm $container
if (!$?) {
    exit 1
}
Copy-Item -Recurse $env:INPUT_APP/* $env:INPUT_DIST
if (!$?) {
    exit 1
}
Write-Output "* binary" > $env:INPUT_DIST/.gitattributes
if (!$?) {
    exit 1
}
Write-Output "" > $env:INPUT_DIST/.nojekyll
if (!$?) {
    exit 1
}
$(Get-Content $env:INPUT_DIST/404.html) -Replace "<base href=""/"" />", "<base href=""$env:INPUT_DOMAIN"" />" > $env:INPUT_DIST/404_new.html
if (!$?) {
    exit 1
}
$(Get-Content $env:INPUT_DIST/404_new.html) -Replace "sparedirectEncode(l, 0)", "sparedirectEncode(l, $env:INPUT_SEGMENTCOUNT)" > $env:INPUT_DIST/404.html
if (!$?) {
    exit 1
}
Remove-Item $env:INPUT_DIST/404_new.html
if (!$?) {
    exit 1
}
$(Get-Content $env:INPUT_DIST/index.html) -Replace "<base href=""/"" />", "<base href=""$env:INPUT_DOMAIN"" />" > $env:INPUT_DIST/index_new.html
if (!$?) {
    exit 1
}
Move-Item $env:INPUT_DIST/index_new.html $env:INPUT_DIST/index.html -Force
if (!$?) {
    exit 1
}