#!/bin/sh

# install zsh curl git.
read -p '该脚本用于安装并配置 zsh 和 oh-my-zsh ，继续？[Y/n]: ' reply
if [ "$reply" != "Y" ]; then
	echo '操作终止..'
	exit 0
fi

echo '依赖软件包： zsh, curl, git, powerline'
echo '安装以上软件需要以 root 用户身份进行！'
echo '请输入 root 用户密码以授权访问...'
su root -c 'yum updateinfo && yum install -y zsh curl git powerline'
if [ $? -ne 0  ]; then
	echo '操作异常终止..'
	exit 1
fi

# install oh-my-zsh.
echo '安装 oh-my-zsh ...'
unset ZSH
export RUNZSH=no
rm -rf $HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ ! -d "$HOME/.oh-my-zsh"  ]; then
	echo '安装失败...'
        exit 1
fi

echo '安装 zsh-autosuggestions ...'
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ $? -ne 0  ]; then
        exit 1
fi

echo '安装 zsh-syntax-highlighting ...'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ $? -ne 0  ]; then
        exit 1
fi

echo "# If you come from bash you might have to change your \$PATH.
# export PATH=\$HOME/bin:/usr/local/bin:\$PATH

# Path to your oh-my-zsh installation.
export ZSH=\"$HOME/.oh-my-zsh\"

# Set name of the theme to load --- if set to \"random\", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo \$RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=\"avit\"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( \"robbyrussell\" \"agnoster\" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE=\"true\"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE=\"true\"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE=\"true\"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT=\"true\"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS=\"true\"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE=\"true\"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION=\"true\"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS=\"true\"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY=\"true\"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# \"mm/dd/yyyy\"|\"dd.mm.yyyy\"|\"yyyy-mm-dd\"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS=\"%m%d %H:%M:%S\"

# Would you like to use another custom folder than \$ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	z
	git
	sudo
	emoji
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source \$ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH=\"/usr/local/man:\$MANPATH\"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n \$SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS=\"-arch x86_64\"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run \`alias\`.
#
# Example aliases
# alias zshconfig=\"mate ~/.zshrc\"
# alias ohmyzsh=\"mate ~/.oh-my-zsh\"" > $HOME/.zshrc

echo 'zsh 和 oh-my-zsh 安装配置完毕..'
exec zsh -l

