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

function getReleaseDeploymentTagName() {
    releaseName=$1
    deploymentTag="$releaseName#deployed"
    echo ${deploymentTag}
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

function createDeploymentTag() {
    releaseName=$1
    deploymentTag=`getReleaseDeploymentTagName ${releaseName}`
    tagExists=`tagExists ${deploymentTag}`
    if [ $tagExists -eq 1 ]; then
        logInfoMessage "Creating deployment tag ${deploymentTag} for ${releaseName} release"
        git tag ${deploymentTag}
    else
        logErrorMessage "Deployment tag ${deploymentTag} alread exists for ${releaseName} release, please delete the tag first"

    fi
}

function getReleaseCommits() {
    releaseName=$1
    previousReleaseName=$2
    logInfoMessage "Listing out commits done between ${previousReleaseName} and ${releaseName} release"
    logInfoMessage "Or you can say commits of ${releaseName}"

    releaseTag="${releaseName}#release"
    previousReleaseTag="${previousReleaseName}#release"
    git log ${previousReleaseTag} ${releaseTag} --pretty=%H > ${releaseName}.commits
    cat ${releaseName}.commits
}

function getCommitLTTR() {
    commitId=$1
    releaseName=$2
    logInfoMessage "I'll get the LTTR for provided commit id ${commitId} in release ${releaseName}"
    releaseDeploymentTag=`getReleaseDeploymentTagName ${releaseName}`
    logInfoMessage "Deployment tag of release is ${releaseDeploymentTag}"
}

#createReleaseTag "getReleaseCommits"
createDeploymentTag "getReleaseCommits"
#getReleaseCommits createDeploymentTag createReleaseTag
#getCommitLTTR 79f32cac049cd2579aab555007aa82ba179b915a createDeploymentTag