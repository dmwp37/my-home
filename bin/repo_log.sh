#!/bin/bash

# get the lastest tag
tag=$(git describe --abbrev=0)
echo last tag is: $tag

# list logs since last tag
repo forall -c "pwd && git lg $tag.."

