# WASM Github Pages Generate

Use AcBlog WASM Client to generate github pages.

## Getting Started

### Workflow

```yml
name: Deploy
on:
  push:
jobs:
  update:
    runs-on: ubuntu-latest
    continue-on-error: false
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false
      - name: Generate Frontend
        uses: acblog/wasm-ghpages-generate-action@master
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@releases/v3
        with:
          ACCESS_TOKEN: ${{ secrets.PUSH_TOKEN }}
          BRANCH: master
          FOLDER: dist
          CLEAN: true
```

### Options

1. `domain`: Folder path in domain, ends with '/', default to '/'.
2. `segmentCount`: Segment count in domain, default to '0'. If your pages under sub-path (eg. `example.com/sub/`), set `segmentCount` to 1.
3. `app`: App directory with settings files, not endswith '/', default to './app'.
4. `dist`: Dist directory, not endswith '/', default to './dist'.
