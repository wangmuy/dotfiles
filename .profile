# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
export JAVA_HOME=$HOME/bin/jdk1.7.0_79
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$JAVA_HOME/bin:$PATH"
fi

export ANDROID_SDK=$HOME/android-sdk
export ANDROID_NDK=$HOME/android-ndk

export PATH=$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$PATH:$HOME/bin/nodejs/bin:$HOME/bin/gradle/latest/bin
