ZSH=$HOME/.oh-my-zsh

# test

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Add ruby version on prompt (float right)
if [ -x "$(command -v rbenv)" ]; then RPS1='[$(ruby_prompt_info)]$EPS1'; fi

# Useful plugins for Rails development with Sublime Text
plugins=(gitfast brew rbenv last-working-dir common-aliases sublime zsh-syntax-highlighting zsh-autosuggestions history-substring-search)

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
export PATH="./bin:${PATH}"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"

# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Aliases
alias gst="git status"
alias gco="git checkout"
alias gcd="git checkout development && git pull"
alias gap="git add -p"
alias gcm="git commit -m $1"
alias gp="git push"
alias brspec="bin/rspec"
alias api-core="cd /Users/romualdescande/code/matera/api-core"
alias api-hubspot="cd /Users/romualdescande/code/matera/api-hubspot"
alias api-public="cd /Users/romualdescande/code/matera/api-public"
alias api-banking="cd /Users/romualdescande/code/matera/api-banking"
alias app-core="cd /Users/romualdescande/code/matera/app-core"
alias app-admin="cd /Users/romualdescande/code/matera/app-admin"
alias app-public="cd /Users/romualdescande/code/matera/app-public"
alias matera-utils="cd /Users/romualdescande/code/matera/matera-utils"
alias npm-packages="cd /Users/romualdescande/code/matera/npm-packages"
