
#!/bin/bash
BSS_DEV_PATH="${HEP_PROJECT_ROOT}/DEV";export BSS_DEV_PATH

if [ ! -d "${BSS_DEV_PATH}" ] ; then
  mkdir ${BSS_DEV_PATH}
fi

python ${HEP_PROJECT_ROOT}/recipes/git_projects.py

# now the paths
NTP_PATH=${BSS_DEV_PATH}/NTP/bin
DPS_PATH=${BSS_DEV_PATH}/DPS/bin
NTP_PYTHONPATH=${BSS_DEV_PATH}/NTP/python
DPS_PYTHONPATH=${BSS_DEV_PATH}/DPS
# clean
PATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PATH" "${NTP_PATH}"`
PATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PATH" "${DPS_PATH}"`
PYTHONPATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PYTHONPATH" "${NTP_PYTHONPATH}"`
PYTHONPATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PYTHONPATH" "${DPS_PYTHONPATH}"`
# add projects to PATH and PYTHONPATH
PATH=${NTP_PATH}:${DPS_PATH}:$PATH; export PATH
PYTHONPATH=${NTP_PYTHONPATH}:${DPS_PYTHONPATH}:$PYTHONPATH; export PYTHONPATH
