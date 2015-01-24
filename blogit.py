#!/usr/bin/env python

import os
import glob

dirs = {
  'root' : os.path.abspath(os.path.dirname(__file__)),
  'blog' : 'blog',
  'posts' : 'blog/posts'
}

test_file_name = 'test.md'

# OS interactions
def read_file(file_name):
  return ''.join(open(file_name, 'r+'))

def write_file(file_name, content):
  open(file_name, 'w+').write(content)

def cmd(cmd):
  return os.popen(cmd).read().strip()

# Git interactions
def git_changed():
  return cmd('git show --pretty=format: --name-only')

print (git_changed())
#for file in last_files.keys():
# for file in glob.glob(dirs['articles']['md'] + "/*.md"):
  
#   if (file.startswith(dirs['articles']['md'])):
#     html = markdown.markdown(read_file(file))

#     md_file_name = file[len(dirs['articles']['md']):]

#     if (md_file_name.endswith('.md')):
#       md_file_name = md_file_name[:-3]

#     md_file_name += '.html'

    


