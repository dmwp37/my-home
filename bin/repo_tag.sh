#!/bin/bash

# $* command to run

usage()
{
    echo "usage: repo_tag [-d] tag_name"
}

exec_cmd()
{
    eval $* || { echo "failed to run: $*"; exit 1; }
}

tag_create()
{
    echo you are going to create tag: $1

    #first sync all git to manifest head
    exec_cmd "repo sync -l"
    #tag all the project
    exec_cmd "repo forall -c git tag -a $1 -m \"version $1\""
    #push the tags to remote
    exec_cmd "repo forall -c git push diag $1"
    #edit .repo/manifest.xml we can't use exec_cmd since bash can't handle quote properly
    #sed -e 's#revision="\([^"]*\)"#revision="refs/tags/'$1'"#g' -i .repo/manifest.xml --follow-symlinks || { echo "failed to modify manifest"; exit 1; }
    #checkout the manifest as detached mode and commit
    #exec_cmd "pushd .repo/manifests"
    #exec_cmd "git checkout --detach"
    #exec_cmd "git commit -a -m \"tag $1\""
    #exec_cmd "git tag -a $1 -m \"version $1\""
    #exec_cmd "git push origin $1"
    #exec_cmd "git checkout default"
    #exec_cmd "popd"

    echo tag $1 created successfully
}

tag_delete()
{
    echo you are going to delete tag: $1

    #delete tag in all projects
    exec_cmd "repo forall -c git tag -d $1"
    #delete the tag from remote
    exec_cmd "repo forall -c git push diag :$1"
    #detete manifest tag
    #exec_cmd "pushd .repo/manifests"
    #exec_cmd "git tag -d $1"
    #exec_cmd "git push origin :$1"
    #exec_cmd "git gc"
    #exec_cmd "popd"

    echo tag $1 deleted successfully
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

if [ ! -d .repo ]; then
    echo you are not in the root direcotry of repo
    exit 1
fi

case "$1" in
    -d)
        if [ $# -lt 2 ]; then
            usage
            exit 1
        fi
        tag_delete $2
        ;;
    *)
        tag_create $1
        ;;
esac
exit 0

