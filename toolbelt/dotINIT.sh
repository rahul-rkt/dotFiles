#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  dotINIT.sh
#   DESCRIPTION:  Setup my dot files < https://github.com/rahul-rkt/dotFiles >
#        AUTHOR:  Rahul Thakur < rahulthakur.me | r@rahulthakur.me >
#       VERSION:  1.0.0
# -----------------------------------------------------------------------------


# OS check
if [ "$(uname -s)" != "Darwin" ]; then
    echo -e "\n\n\e[1;91m Error:          UNSUPPORTED OS \n\e[2;93m Dependency:     OS X \n\e[1;92m Solution:       Do it manually! \n\n\e[0;0m rINIT will exit now.. \n"
    exit 1
fi
# -----------------------------------------------------------------------------


# Clone dotFiles --------------------------------------------------------------
echo -e "\n\e[1;94m Clone dotFiles in the current directory? \e[2;93mEnter FULL_PATH or leave blank \n\e[0;0m"
read dir

if [ -z "$dir" ]; then
    dir=$(pwd)
fi

git clone git@github.com:rahul-rkt/dotFiles.git $dir
cd $dir
# -----------------------------------------------------------------------------


# Setup symLinks --------------------------------------------------------------
cd ~

# rcs & confs
ln -s $dir/.zshrc
ln -s $dir/.tmux.conf
ln -s $dir/.tmuxinator
ln -s $dir/.nanorc
ln -s $dir/.nano
ln -s $dir/.gitignore_global
ln -s $dir/.gitconfig
ln -s $dir/.bashrc
cp $dir/.htoprc .

# atom
mkdir .atom > /dev/null 2>&1
ln -s $dir/.atom/styles.less ./.atom
ln -s $dir/.atom/snippets.cson ./.atom
ln -s $dir/.atom/packages.cson ./.atom
ln -s $dir/.atom/keymap.cson ./.atom
ln -s $dir/.atom/init.coffee ./.atom
ln -s $dir/.atom/config.cson ./.atom

# scripts
ln -s $dir/toolbelt/battery.sh

cd -
# -----------------------------------------------------------------------------
