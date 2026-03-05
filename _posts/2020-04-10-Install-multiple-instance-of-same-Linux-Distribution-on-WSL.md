---
layout: post
title:  "Install Multiple Instances of the Same Linux Distribution on WSL"
tags: [ WSL, Linux, Windows 10, Ubuntu ]
featured_image_thumbnail: /assets/images/posts/2020/2020-04-10/Ubuntu-on-Windows-10.jpg
featured_image: /assets/images/posts/2020/2020-04-10/Ubuntu-on-Windows-10.jpg
featured: true
hidden: true
---
There are many cases where we need different instances of Ubuntu with different configurations on WSL,
but by default, we can only install one instance of each Linux Distribution on WSL via the Microsoft Store.
To solve this issue, we can follow one of these approaches:
- Import a raw version of an exported WSL instance with a different name
- Download a Linux Distribution package from the Windows Store and import it as a different WSL instance

In this tutorial, I am following the second approach to install a new instance of Linux on WSL.

### Download Linux Distribution
Download your preferred Linux distribution from the Microsoft website:     
- [Ubuntu 18.04](https://aka.ms/wsl-ubuntu-1804)
- [Ubuntu 18.04 ARM](https://aka.ms/wsl-ubuntu-1804-arm)
- [Ubuntu 16.04](https://aka.ms/wsl-ubuntu-1604)
- [Debian GNU/Linux](https://aka.ms/wsl-debian-gnulinux)
- [Kali Linux](https://aka.ms/wsl-kali-linux-new)
- [OpenSUSE Leap 42](https://aka.ms/wsl-opensuse-42)
- [SUSE Linux Enterprise Server 12](https://aka.ms/wsl-sles-12)
- [Fedora Remix for WSL](https://github.com/WhitewaterFoundry/WSLFedoraRemix/releases/)

### Extract Linux Distribution
The extension of the downloaded file is APPX, but you can extract it with [7-Zip](https://www.7-zip.org/).
Extract it to a folder with the same name as the distribution.

### Install New Instance of Linux in WSL
In the extracted folder, you will find a file named **install.tar.gz**.
The only step left is to import this file as a new instance of Linux in WSL.

The WSL import command contains 4 parts:
- **--import** - Indicates that you want to import a new instance
- **Instance Name** - A unique name that allows you to access this instance in the future
- **Installation Path** - The location where Linux will persist file system information
- **install.tar.gz Path** - The path to the install.tar.gz file

<pre><code class="language-bash">wsl --import Ubuntu-18.04_New [Installation Path] [The Extracted Folder]\install.tar.gz

For example:

wsl --import Ubuntu-18.04_New C:\WSL\Data\Ubuntu-18.04-New C:\Downloads\Ubuntu18.04\install.tar.gz
</code></pre>

### View List of Available Instances
Run the following command to see Ubuntu-18.04_New added as an available WSL instance:
<pre><code class="language-bash">wsl --list</code></pre>

### Run Imported Instance and Add Sudoer User
When you run an instance for the first time, you will be logged in as the root user:
<pre><code class="language-bash">wsl --distribution Ubuntu-18.04_New</code></pre>

Most of the time, you'll want to log in with a specific user. To do this, first log in to your new instance and execute the following commands to create a new user and add it to the sudoer group:
<pre><code class="language-bash">useradd testUser
passwd testUser
usermod -aG sudo testUser</code></pre>

### Run Imported Instance with Specific User
<pre><code class="language-bash">wsl --distribution Ubuntu-18.04_New --user testUser</code></pre>

