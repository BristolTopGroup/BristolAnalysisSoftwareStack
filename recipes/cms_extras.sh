#!/bin/bash
# for CMSSW
if [ -f /cvmfs/cms.cern.ch/cmsset_default.sh ]; then
	source /cvmfs/cms.cern.ch/cmsset_default.sh
	export CMSSW_GIT_REFERENCE=/cvmfs/cms.cern.ch/cmssw.git
fi

# CRAB submission
# https://twiki.cern.ch/twiki/bin/view/CMSPublic/CRAB3Releases#Improvements_enhancements_change
if [ -f /cvmfs/cms.cern.ch/crab3/crab.sh ]; then
	source /cvmfs/cms.cern.ch/crab3/crab.sh
fi
