# Demo Manifests and Code Used in DevOps Toolkit Videos

[![Master Terminal Multiplexing with Zellij in Minutes!](https://img.youtube.com/vi/ZndhImXIGlg/0.jpg)](https://youtu.be/ZndhImXIGlg)
[![From Makefile to Justfile (or Taskfile): Recipe Runner Replacement](https://img.youtube.com/vi/hgNN2wOE7lc/0.jpg)](https://youtu.be/hgNN2wOE7lc)

## Generate manifests

```bash
devbox shell

just package-generate

exit
```

## Run Tests

```bash
devbox shell

just cluster-create

just test-watch

# Stop the watcher with `ctrl+c`

just cluster-destroy

exit
```

## Publish To Upbound

```bash
devbox shell

# Replace `[...]` with the Upbound Cloud account
export UP_ACCOUNT=[...]

# Replace `[...]` with the Upbound Cloud token
export UP_TOKEN=[...]

# Replace `[...]` with the version of the package (e.g., `v0.5.0`)
export VERSION=[...]

just package-publish

exit
```
