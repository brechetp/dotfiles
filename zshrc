# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="webgefrickel"

# default plugins to load
plugins=(brew cap extract git github history-substring-search jake-node laravel npm node gem osx)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# paths
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rvm/bin:$PATH
export MANPATH=/usr/local/share/man:$MANPATH

# disable stupid ._ and dsstore files
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

# editor
export EDITOR=vim
export VISUAL=vim

# node.js
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH

### aliases ##
# aliases for apache and mysql
alias apachestart='_ /usr/sbin/apachectl start'
alias apachestop='_ /usr/sbin/apachectl stop'
alias mysqlstart='mysql.server start'
alias mysqlstop='mysql.server stop'
alias dev='apachestart && mysqlstart'
alias devs='apachestop && mysqlstop'

# start virtuoso
alias virt='cd /usr/local/Cellar/virtuoso/6.1.5/var/lib/virtuoso/db/ && virtuoso-t -df'

# dnsflush-shortcut
alias dnsflush='_ dscacheutil -flushcache'

# all in one homebrew, gem and vim bundles update commands
alias dotup='cd ~/Dotfiles/ && git pull && cd -'
alias dotsubup='cd ~/Dotfiles/ && git submodule foreach git pull && cd -'
alias brewup='brew update && brew upgrade && brew cleanup && brew linkapps'
alias gemup='gem update --system && gem update && gem cleanup'
alias npmup='npm -g cache clean && npm -g update'
alias rvmup='rvm get latest'
alias upall='brewup && rvmup && gemup && npmup && dotup && dotsubup'

# always use vim
alias v='vim'
alias vd='vimdiff'
alias diff='vimdiff'

# easy hosts-editing
alias hosts='_ vim /etc/hosts'
alias vhosts='_ vim /etc/apache2/extra/httpd-vhosts.conf'

# Easier navigation: .., ..., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Shortcuts
alias drop='cd ~/Dropbox && l'
alias web='cd ~/Sites && l'
alias rep='cd ~/Repositories && l'
alias dot='cd ~/Dotfiles && l'

# Gitty gitgit
alias gitrm='git rm $(git ls-files --deleted)'

# dandelion deployment shortcuts
alias deploy='dandelion deploy'
alias status='dandelion status'

# grunt
alias grw='grunt watch'
alias grd='grunt deploy'

# other tools
alias cw='compass watch'


### some custom functions ###
# use ffmpeg to create nice web-videos and a jpg-still
ffencode() { 
  ffmpeg -i $1 -vcodec libx264 -vprofile high -preset slow -vb 1000k -maxrate 1000k -bufsize 2000k -vf scale="854:trunc(ow/a/2)*2" -threads 0 -ab 128k video-low.mp4;
  ffmpeg -i $1 -vcodec libx264 -vprofile high -preset slower -vb 1800k -vf scale="1280:trunc(ow/a/2)*2" -threads 0 -ab 224k video-high.mp4
  ffmpeg -i $1 -vcodec libvpx -quality good -cpu-used 0 -vb 1000k -maxrate 1000k -bufsize 2000k -qmin 10 -qmax 42 -vf scale="854:trunc(ow/a/2)*2" -threads 0 -acodec libvorbis -ab 128k video-low.webm;
  ffmpeg -i $1 -vcodec libvpx -quality good -cpu-used 0 -vb 1800k -maxrate 1800k -bufsize 3600k -qmin 10 -qmax 42 -vf scale="1280:trunc(ow/a/2)*2" -threads 0 -acodec libvorbis -ab 224k video-high.webm;
  ffmpeg -i $1 -ss 00:00:05.01 -y -f image2 -vcodec mjpeg -vframes 1 -s hd720 video-high.jpg
  ffmpeg -i $1 -ss 00:00:05.01 -y -f image2 -vcodec mjpeg -vframes 1 -s hd480 video-low.jpg
  mp4box -inter 500 -hint video-high.mp4
  mp4box -inter 500 -hint video-low.mp4
}

# git search helper
gf() {
  git hist | grep "$*";
}

# rvm ftw!
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
