# zenv: Directory/Project based environments for zsh
Automatically source .zenv files when in a directory/project tree.

# Install
Just load the plugin as you normally would using youre prefered zsh plugin manager.

# Usage
Place a .zenv file in youre project root that you want automatically sourced/evaluated by zsh, thats it.

## Interface
zenv provides an interface for upping and dowing the environment.
### zenv_up
Runs when you enter the project/directory root
```bash
function zenv_up {
    alias zenvtest="echo 'it works!'"}
}
```
### zenv_down
Runs when you exit the project/directory root
```bash
function zenv_down {
    unalias zenvtest
}
```

### ZENV_ROOT
You can use the ZENV_ROOT environment variable in your .zenv file to get root path of the zenv.
```bash
echo $ZENV_ROOT
# /path/to/your/zenv
```
