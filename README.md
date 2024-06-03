# Demo Manifests and Code Used in DevOps Toolkit Videos

[![From Makefile to Justfile (or Taskfile): Recipe Runner Replacement](https://img.youtube.com/vi/hgNN2wOE7lc/0.jpg)](https://youtu.be/hgNN2wOE7lc)oy

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
