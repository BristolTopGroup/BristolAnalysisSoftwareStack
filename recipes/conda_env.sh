#!/bin/bash
TOPQ_CONDA_PATH=/software/TopQuarkGroup/miniconda; export TOPQ_CONDA_PATH
# clean paths
PATH=`python ${HEP_PROJECT_ROOT}/bin/remove_from_env.py "$PATH" "${TOPQ_CONDA_PATH}"`

if [ ! -d "${TOPQ_CONDA_PATH}" ] ; then
  # create all parent folders except miniconda
  echo "Could not find conda install in ${TOPQ_CONDA_PATH}. Installing conda ..."
  mkdir -p ${TOPQ_CONDA_PATH}; rmdir ${TOPQ_CONDA_PATH}
  wget -nv https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
  bash miniconda.sh -b -p ${TOPQ_CONDA_PATH}
  PATH=${TOPQ_CONDA_PATH}/bin:$PATH; export PATH
  rm -f miniconda.sh
  echo "Finished conda installation, creating new conda environment"
  conda update conda -y
  conda update pip -y
  conda install psutil -y
  conda config --add channels http://conda.anaconda.org/NLeSC
  conda config --set show_channel_urls yes
  # create new conda environment with Python 2.7 and ROOT 6
  conda create -n bss python=2.7 root=6 -y
  echo "Created conda environment, installing basic dependencies"
  source activate bss
  conda install --file ${HEP_PROJECT_ROOT}/conda_packages.txt -y
  # install python packages
  pip install -U -r ${HEP_PROJECT_ROOT}/requirements.txt
  # clean the cache (downloaded tarballs)
  conda clean -t -y
  # give the group write access
  chmod g+r -R ${TOPQ_CONDA_PATH}
else
  echo "Found conda install in ${TOPQ_CONDA_PATH}, activating..."
  PATH=${TOPQ_CONDA_PATH}/bin:$PATH; export PATH
  source activate bss
fi
