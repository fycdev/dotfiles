#!/usr/local/bin/zsh

setopt globdots
setopt rematchpcre

cd $(dirname $0)

for item in *; do
    # All files that are not .git*, *.sh, or *.md; or .gitignoreglobal or .gitconfig
    if [[ $item =~ (^(?!(\.git|.+\.(sh|md)$)).+|\.gitignoreglobal$|\.gitconfigglobal$) ]]; then
        if [[ -a ~/$item ]]; then
            echo Removing ~/$item 
            rm -rf ~/$item
        fi
        ln -sv $PWD/$item ~
    fi
done

echo Linking global gitconfig
git config --global --unset include.path '.gitconfigglobal'
git config --global --add include.path ~/.gitconfigglobal

echo Linking global gitignore
git config --global --unset core.excludesFile '.gitignoreglobal'
git config --global --add core.excludesFile ~/.gitignoreglobal
