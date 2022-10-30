#!/bin/bash

function logInfoMessage() {
    MESSAGE="$1"
    CURRENT_DATE=`date "+%D: %T"`
    echo -e "[$CURRENT_DATE] "$COLOR_START$GREEN[INFO]$COLOR_END" $MESSAGE"
}

function createReleaseTag() {
    releaseName=$1
    releaseTag="$releaseName#release"
    logInfoMessage "Creating release tag ${releaseTag} for ${releaseName}"
    git tag ${releaseTag}
}

createReleaseTag "design"