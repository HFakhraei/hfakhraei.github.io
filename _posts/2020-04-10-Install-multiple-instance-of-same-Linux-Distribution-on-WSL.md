---
layout: post
title:  "Install multiple instance of same Linux Distribution on WSL"
tags: [ WSL, Linux, Windows 10 ]
featured_image_thumbnail: assets/images/posts/2020/Ubutntu-on-Windows-10.jpg
featured_image: assets/images/posts/2020/Ubutntu-on-Windows-10.jpg
featured: true
hidden: true
---
There are lots of cases that we need a different instance of Ubuntu with the different configuration on WSL, 
but by default, we could install one instance of each Linux Distribution on WSL via Microsoft store.
To solve this issue we must follow one of these ways:
- Import raw version of exported WSL with a different name.
- Download Linux Distribution Package from Windows Store and try to Import it as a different instance of WSL.
In this tutorial, I am following a second way to install a new instance of Linux on WSL.

### Download Linux Distribution
Download prefer Distribution of Linux from Microsoft website.     
- [Ubuntu 18.04](https://aka.ms/wsl-ubuntu-1804)
- [Ubuntu 18.04 ARM](https://aka.ms/wsl-ubuntu-1804-arm)
- [Ubuntu 16.04](https://aka.ms/wsl-ubuntu-1604)
- [Debian GNU/Linux](https://aka.ms/wsl-debian-gnulinux)
- [Kali Linux](https://aka.ms/wsl-kali-linux-new)
- [OpenSUSE Leap 42](https://aka.ms/wsl-opensuse-42)
- [SUSE Linux Enterprise Server 12](https://aka.ms/wsl-sles-12)
- [Fedora Remix for WSL](https://github.com/WhitewaterFoundry/WSLFedoraRemix/releases/)

### Extract Linux Distribution
Extension of the downloaded file is APPX but you can extract it with [7Zip](https://www.7-zip.org/).
Try to extract it to a folder with the same name.

### Install new Instance of Linux in WSL
In an extracted folder you will find file **install.tar.gz**.
The only step left is to import this file as a new instance of Linux in WSL.
A WSL command contain 4 parts to import new instance:
- **--import** This section show that you want to import new instance.
- **Instance Name** This is unique name, that let us access to instance in future.
- **Installation Path** This is a location, that linux persist file system information.
- **install.tar.gz Path** This is a path of install.tar.gz file. 

<pre><code class="language-markup"> wsl --import Ubuntu-18.04_New [Intallation Path] [The Exctracted Folder]\install.tar.gz

for example 

 wsl --import Ubuntu-18.04_New C:\WSL\Data\Ubuntu-18.04-New C:\Downloads\Ubuntu18.04\install.tar.gz
</code></pre>

### View list of available instance
If you run the following command, you can see Ubuntu-18.04_New added as an available WSL instance.
<pre><code class="language-markup"> wsl --list </code></pre>

### Run a imported instance and add Sudoer user
When for the first time, you run an instance you will see your login with root user.
<pre><code class="language-markup"> wsl --distribution Ubuntu-18.04_New </code></pre>

But most of the time, you want to login with a specific user. To do this first login to your new instance and execute 
following commands to create a new user and add it to the Sudoer group.
<pre><code class="language-markup"> useradd testUser
 passwd testUser
 usermod -aG sudo testUser 
</code></pre>
  
### Run a imported instance with testUser
<pre><code class="language-markup"> wsl --distribution Ubuntu-18.04_New --user testUser</code></pre>

