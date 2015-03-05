#!/bin/bash

# DWTFYWWI LICENSE 
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
# 0. The author grants everyone permission to do whatever the fuck they 
# want with the software, whatever the fuck that may be. 


# shopt -s expand_aliases
# alias sed=gsed

markdown_lib="./markdown.pl"

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

html_template=$(< "$templates_dir/post.html")

content_pttrn='{{content}}'
content_pttrn_len=${#content_pttrn}
content_pttrn_pos=$(strindex "$html_template" "$content_pttrn")
title_pttrn='{{title}}'
title_pttrn_len=${#title_pttrn}
title_pttrn_pos=$(strindex "$html_template" "$title_pttrn")

for md_file in $md_dir/*.md
do
  html_file=$html_dir/${md_file:$md_dir_len+1:${#md_file}-$md_dir_len-4}.html  

  md_content=$(< $md_file)

  title=""
  while IFS=$'\n' read -ra ADDR; do
    title=$(echo "${ADDR[@]}" | sed 's/^[ #]*//g' | sed 's/[ #]*$//g')
    break
  done <<< "$md_content"
  title=$(echo "$title" | sed -e 's/[\/&]/\\&/g')  

  html_content=${html_template:0:title_pttrn_pos}
  html_content=$html_content$title
  html_content=$html_content${html_template:title_pttrn_pos+title_pttrn_len}

  html_content=${html_content:0:$(strindex "$html_content" "$content_pttrn")}
  html_content=$html_content$(echo "$md_content" | $markdown_lib)
  html_content=$html_content${html_template:$content_pttrn_pos+content_pttrn_len}

  echo "$html_content" > $html_file
done