from __future__ import print_function
import os
from git import GitConfigParser, Repo
import six

# github group
GROUP = "BristolTopGroup"
# mapping of github user names to aliases (for remotes)
DEVELOPERS = {
    "DouglasBurns": "doug",
    "EmyrClement": 'emyr',
    "kreczko": 'luke',
}
GITHUB_BASE = "https://github.com/" + GROUP + "/"
GITHUB_SSH = 'git@github.com:'
PROJECTS = {
    'NTP': GITHUB_BASE + "NTupleProduction.git",
    'AS': GITHUB_BASE + "AnalysisSoftware.git",
    'DPS': GITHUB_BASE + "DailyPythonScripts.git",
}

globalconfig = GitConfigParser(
    [os.path.normpath(os.path.expanduser("~/.gitconfig"))], read_only=True)
USER = globalconfig.get('user', 'name')


DEV_PATH = os.environ.get('BSS_DEV_PATH')

for alias, git_url in six.iteritems(PROJECTS):
    repo_dir = os.path.join(DEV_PATH, alias)
    if os.path.exists(repo_dir):
        print(">> Repo {0} already exists".format(repo_dir))
        continue
    print('>> Cloning {0}'.format(git_url))
    Repo.clone_from(git_url, repo_dir)
    repo = Repo(repo_dir)
    # rename origin
    repo.remotes.origin.rename('upstream')
    for github_name, dev_alias in six.iteritems(DEVELOPERS):
        remote_url = git_url.replace(GROUP, github_name)
        remote_alias = dev_alias
        if github_name == USER:
            # use git+ssh for the user's fork
            remote_url = remote_url.replace(GITHUB_BASE, GITHUB_SSH)
            remote_alias = 'origin'
        print('>>>> Adding remote {0}'.format(remote_url))
        repo.create_remote(remote_alias, remote_url)
    print('>>>> Fetching all remotes for {0}'.format(alias))
    for remote in repo.remotes:
        remote.fetch()
