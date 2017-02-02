#!/bin/bash

if [ -n "${HEP_PROJECT_ROOT}" ] ; then
   old_projectbase=${HEP_PROJECT_ROOT}
fi


if [ "x${BASH_ARGV[0]}" = "x" ]; then
    if [ ! -f bin/env.sh ]; then
        echo ERROR: must "cd where/project/is" before calling ". bin/env.sh" for this version of bash!
        HEP_PROJECT_ROOT=; export HEP_PROJECT_ROOT
        return 1
    fi
    HEP_PROJECT_ROOT="$PWD"; export HEP_PROJECT_ROOT
else
    # get param to "."
    envscript=$(dirname ${BASH_ARGV[0]})
    HEP_PROJECT_ROOT=$(cd ${envscript}/..;pwd); export HEP_PROJECT_ROOT
fi

if [ -n "${old_projectbase}" ] ; then
  PATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PATH" "${old_projectbase}"`
  PYTHONPATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PYTHONPATH" "${old_projectbase}"`
fi

if [ -z "${PYTHONPATH}" ]; then
   PYTHONPATH=$HEP_PROJECT_ROOT/python; export PYTHONPATH
else
   PYTHONPATH=$HEP_PROJECT_ROOT/python:$PYTHONPATH; export PYTHONPATH
fi

unset old_projectbase
unset envscript

source ${HEP_PROJECT_ROOT}/recipes/conda_env.sh
source ${HEP_PROJECT_ROOT}/recipes/cms_extras.sh
source ${HEP_PROJECT_ROOT}/recipes/grid_tools.sh
source ${HEP_PROJECT_ROOT}/recipes/git_projects.sh

# make sure BSS is at the start of PATH
if [ -z "${PATH}" ]; then
   PATH=$HEP_PROJECT_ROOT/bin; export PATH
else
   PATH=$HEP_PROJECT_ROOT/bin:$PATH; export PATH
fi

echo "The Bristol Software Stack is now ready to go"

# fix for a current NTP problem
if [ ! -L "setup.json" ]
then
	ln -s DEV/NTP/setup.json setup.json
fi

#bss setup
