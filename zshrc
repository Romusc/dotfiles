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
alias api-core="cd ~/code/romusc/matera/api-core"
alias api-hubspot="cd ~/code/romusc/matera/api-hubspot"
alias api-banking="cd ~/code/romusc/matera/api-banking"
alias app-core="cd ~/code/romusc/matera/app-core"
alias app-admin="cd ~/code/romusc/matera/app-admin"
alias app-public="cd ~/code/romusc/matera/app-public"
alias matera-utils="cd ~/code/romusc/matera/matera-utils"
alias npm-packages="cd ~/code/romusc/matera/npm-packages"
alias kapi-core="kubectl exec -n api-core-production -i -t \$(kubectl get pod -n api-core-production -l app=api-core-rails -o name) -- bash"
alias kapi-hubspot="kubectl exec -n api-hubspot-production -i -t \$(kubectl get pod -n api-hubspot-production -l app=api-hubspot-rails -o name) -- bash"

alias start-api-core="cd ~/code/romusc/matera/api-core && git pull origin development && bundle install && rails db:migrate && rails s"
alias start-api-hubspot="cd ~/code/romusc/matera/api-hubspot && git pull origin development && bundle install && rails db:migrate && rails s"
alias start-app-core="cd ~/code/romusc/matera/app-core && yarn start"
alias start-app-admin="cd ~/code/romusc/matera/app-admin && yarn start"
alias start-app-public="cd ~/code/romusc/matera/app-public && git pull origin development && yarn && gatsby clean && gatsby develop"
alias serve-app-public="yarn && gatsby clean && gatsby build && gatsby serve"

# I have removed the git reset hard from Roger's script for security
# alias start-api-banking="cd ~/code/romusc/matera/api-banking && git reset --hard && git pull origin development && bundle install && rails db:migrate && rails s"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
function iterm () {
    local cmd=""
    local wd="$PWD"
    local args="$@"
    if [ -d "$1" ]; then
        wd="$1"
        args="${@:2}"
    fi
    if [ -n "$args" ]; then
        # echo $args
        cmd="; $args"
    fi
    osascript &>/dev/null <<EOF
        tell application "iTerm2"
          tell current window
            create tab with default profile
            tell current session of current tab
              delay 1
              write text "cd $wd$cmd"
            end tell
          end tell
        end tell
EOF
}
alias start-matera="pkill -9 ruby; iterm start-api-core && iterm start-api-hubspot && iterm start-app-core && iterm start-app-admin"
