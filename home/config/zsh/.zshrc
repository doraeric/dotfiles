# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# default to $XDG_DATA_HOME/oh-my-zsh if ZSH is not set
export ZSH="${ZSH:-$XDG_DATA_HOME/oh-my-zsh}"

# XDG directories
# https://github.com/ohmyzsh/ohmyzsh/issues/7332
HISTFILE="${XDG_STATE_HOME:-$XDG_DATA_HOME}/zsh/history"
if [[ ! -e "$(dirname $HISTFILE)" ]]; then mkdir "$(dirname $HISTFILE)"; fi
if [[ ! -e "$XDG_CACHE_HOME/zsh" ]]; then mkdir "$XDG_CACHE_HOME/zsh"; fi
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$HOST-$ZSH_VERSION"
setopt HIST_IGNORE_SPACE

# Fix buggy paste behaviour in quotes
# oh-my-zsh enables auto escaping characters for urls, but it's buggy in quotes
# To make it work correctly, either disable bracketed-paste-magic or
# use backward-extend-paste
# https://stackoverflow.com/questions/25614613/#answer-25622864 in comments
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/bracketed-paste-magic
zstyle :bracketed-paste-magic paste-init backward-extend-paste

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
ZSH_THEME="bullet-train"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  docker
  docker-compose
)
if command -v rustc &> /dev/null; then plugins+=(rust); fi
if command -v rustup &> /dev/null; then plugins+=(rustup); fi
if command -v cargo &> /dev/null; then plugins+=(cargo); fi
# zsh-syntax-highlighting must be at the end
plugins+=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Bullet Train for oh-my-zsh
BULLETTRAIN_PROMPT_ORDER=(
    time
    status
    custom
    # context
    dir
    screen
    perl
    ruby
    virtualenv
    # nvm
    aws
    go
    elixir
    git
    hg
    cmd_exec_time
)
BULLETTRAIN_VIRTUALENV_FG=blue

# for tmux windows title
DISABLE_AUTO_TITLE=true

# time command format
TIMEFMT=$'\nreal\t%*Es\tcpu\t%P\nuser\t%*Us\tsys\t%*Ss'

# virtualenvwrapper
# Since source virtualenvwrapper.sh is slow, load it dynamically
# The workon function will be replaced after sourced real script
# `source virtualenvwrapper.sh` fails when `command python` fails
# Some systems only have python3 command, so try it first
if command -v python3 2>&1 >/dev/null; then
    export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)
fi
# source "`command -v virtualenvwrapper_lazy.sh`"
# _vw=
# if [ -r "$HOME/.local/bin/virtualenvwrapper.sh" ] # pip install --user
# then _vw="$HOME/.local/bin/virtualenvwrapper.sh"
# elif [ -r "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ] # apt-get install
# then _vw="/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
# elif [ -r /usr/local/bin/virtualenvwrapper.sh ] # sudo pip install
# then _vw=/usr/local/bin/virtualenvwrapper.sh
# elif [ -r /usr/bin/virtualenvwrapper.sh ]
# then _vw=/usr/bin/virtualenvwrapper.sh
# elif which virtualenvwrapper.sh 1>/dev/null
# then _vw="`which virtualenvwrapper.sh`"
# fi
# if [ -n "$_vw" ]; then
#     function workon {
#         source "$_vw"
#         workon $@
#     }
#     _load_virtu() {
#         source "$_vw"
#         reply=(`workon`)
#     }
#     compctl -K _load_virtu workon
# fi

# https://gnunn1.github.io/tilix-web/manual/vteconfig/
# https://unix.stackexchange.com/questions/310647/new-tab-in-bash-on-arch-linux-starts-at-home-directory
if [[ -e /etc/profile.d/vte.sh ]]; then
  # manjaro
  source /etc/profile.d/vte.sh
elif [[ -e /etc/profile.d/vte-2.91.sh ]]; then
  # ubuntu
  source /etc/profile.d/vte-2.91.sh
fi

# oh-my-zsh change LESS in  ~/.oh-my-zsh/lib/misc.zsh
# https://stackoverflow.com/questions/37187501
# above less version 530, use "-R" is fine
# below the version, use smartless as alternative
# default git LESS:
# export LESS="-FRX"

if [ -f ~/.zshrc.local ]; then source ~/.zshrc.local; fi
