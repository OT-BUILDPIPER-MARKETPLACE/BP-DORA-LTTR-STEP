#!/bin/bash

function logInfoMessage() {
    MESSAGE="$1"
    CURRENT_DATE=`date "+%D: %T"`
    echo -e "[$CURRENT_DATE] "$COLOR_START$GREEN[INFO]$COLOR_END" $MESSAGE"
}

function logErrorMessage() {
    MESSAGE="$1"
    CURRENT_DATE=`date "+%D: %T"`
    echo -e "[$CURRENT_DATE] "$COLOR_START$RED[ERROR]$COLOR_END" $MESSAGE"
}

function tagExists() {
    tagName=$1
    tagListName=`git tag -l $tagName`
    if [ "$tagListName" = "$tagName" ]; then
        tagExists=0
    else
        tagExists=1
    fi
    echo $tagExists
}

function createReleaseTag() {
    releaseName=$1
    releaseTag="$releaseName#release"
    tagExists=`tagExists ${releaseTag}`
    if [ $tagExists -eq 1 ]; then
        logInfoMessage "Creating release tag ${releaseTag} for ${releaseName}"
        git tag ${releaseTag}
    else
        logErrorMessage "Release tag ${releaseTag} alread exists for ${releaseName}, please delete the tag first"

    fi
}

createReleaseTag "design"