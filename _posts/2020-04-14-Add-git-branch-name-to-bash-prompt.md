---
layout: post
title:  "Add git branch name to Ubuntu bash prompt"
tags: [ Git, Linux, WSL ]
featured_image_thumbnail: /assets/images/posts/2020/2020-04-14/Ubuntu-Git-Github.jpg
featured_image: /assets/images/posts/2020/2020-04-14/Ubuntu-Git-Github.jpg
featured: true
hidden: true
---
If you are working mostly in linux terminal and working with Git, you know that, how usefull having **Git branch name**
in bash prompt. 
By default, bash prompt is like this.

{% include image-caption.html imageurl="/assets/images/posts/2020/2020-04-14/Bash-Prompt.jpg" caption="Normal bash prompt" %}

To include Git branch name in bash prompt you need to edit **.bashrc** file in user home directory and add these lines. 

<pre><code class="language-java"> git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
 }
 export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W \[\033[01;33m\]\$(git_branch)\[\033[00m\]\$ "
</code></pre>

After applying these changes, your bash prompt will show Git branch name like this.

{% include image-caption.html imageurl="/assets/images/posts/2020/2020-04-14/Bash-Prompt-with-Git-branch-name.jpg" caption="Bash Prompt with Git branch name" %}



