#!/usr/bin/env python

import os
import glob
import markdown
from git import Repo

dirs = {
  'root' : os.path.abspath(os.path.dirname(__file__)),
  'articles' : {
    'md' : 'private/articles',
    'html': 'public/articles'
  }
}

git = {
  'repo' : Repo(dirs['root'])
}

test_file_name = 'private/articles/test.md'

def read_file(file_name):
  return ''.join(open(file_name, 'r+'))



repo = Repo(dirs['root'])
repo_head = repo.head
last_files = repo_head.commit.stats.files

#for file in last_files.keys():
for file in glob.glob(dirs['articles']['md'] + "/*.md"):
  
  if (file.startswith(dirs['articles']['md'])):
    html = markdown.markdown(read_file(file))

    md_file_name = file[len(dirs['articles']['md']):]

    if (md_file_name.endswith('.md')):
      md_file_name = md_file_name[:-3]

    md_file_name += '.html'

    with open(dirs['articles']['md'] + '/' + md_file_name, 'w+') as f:
      f.write(html)


