#!/bin/bash

md_dir="./markdown"
md_dir_len=${#md_dir}

www_dir="./www"
html_dir="$www_dir/html"
posts_dir="$html_dir/posts"

for md_file in $md_dir/*.md
do
  md_content=$(< $md_file)

  html_file=$html_dir/${md_file:$md_dir_len+1:${#md_file}-$md_dir_len-4}.html
  html_content=$(echo "$md_content" | ./markdown.sh)

  echo "$html_content" > $html_file
done