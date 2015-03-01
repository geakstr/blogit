#!/bin/bash

# shopt -s expand_aliases
# alias sed=gsed

strindex() { 
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1 || echo ${#x}
}

md_dir="./markdown"
md_dir_len=${#md_dir}

www_dir="./www"
html_dir="$www_dir/html"
posts_dir="$html_dir/posts"

templates_dir="./templates"

post_html_template=$(< "$templates_dir/post.html")

content_pattern='{{content}}'
content_pattern_len=${#content_pattern}
content_pattern_pos=$(strindex "$post_html_template" "$content_pattern")
title_pattern='{{title}}'
title_pattern_len=${#title_pattern}
title_pattern_pos=$(strindex "$post_html_template" "$title_pattern")

for md_file in $md_dir/*.md
do
  html_file=$html_dir/${md_file:$md_dir_len+1:${#md_file}-$md_dir_len-4}.html  

  md_content=$(./markdown.pl $md_file)

  title=""
  while IFS="\n" read -ra ADDR; do
    title=$(echo "${ADDR[@]}" | sed 's/^[ #]*//g' | sed 's/[ #]*$//g')
    break
  done <<< "$md_content"
  title=$(echo "$title" | sed -e 's/[\/&]/\\&/g')  

  html_content=${post_html_template:0:title_pattern_pos}
  html_content=$html_content$title
  html_content=$html_content${post_html_template:title_pattern_pos+title_pattern_len}

  html_content=${html_content:0:$(strindex "$html_content" "$content_pattern")}
  html_content=$html_content$(echo "$md_content" | ./markdown.sh)
  html_content=$html_content${post_html_template:$content_pattern_pos+content_pattern_len}

  echo "$html_content" > $html_file
done