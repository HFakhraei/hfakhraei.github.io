---
layout: post
title:  "Add Git Branch Name to Ubuntu Bash Prompt"
tags: [ Git, Linux, WSL, Bash ]
featured_image_thumbnail: /assets/images/posts/2020/2020-04-14/Ubuntu-Git-Github.jpg
featured_image: /assets/images/posts/2020/2020-04-14/Ubuntu-Git-Github.jpg
featured: true
hidden: true
---
If you work mostly in the Linux terminal and use Git, you know how useful it is to have the **Git branch name** displayed in your bash prompt.

By default, the bash prompt looks like this:

{% include image-caption.html imageurl="/assets/images/posts/2020/2020-04-14/Bash-Prompt.jpg" caption="Normal bash prompt" %}

To include the Git branch name in your bash prompt, you need to edit the **.bashrc** file in your user home directory and add these lines:

<pre><code class="language-bash">git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W \[\033[01;33m\]\$(git_branch)\[\033[00m\]\$ "
</code></pre>

After applying these changes, your bash prompt will display the Git branch name like this:

{% include image-caption.html imageurl="/assets/images/posts/2020/2020-04-14/Bash-Prompt-with-Git-branch-name.jpg" caption="Bash Prompt with Git branch name" %}



