# Personal Dotfiles
## Setup

Before running the setup, you should install the following programs:
- Neovim: https://github.com/neovim/neovim/wiki/Installing-Neovim
    - On mac you should be able to run: `brew install neovim`. This should be confirmed with the
    above link.
- Kitty terminal: https://sw.kovidgoyal.net/kitty/binary/
    - On mac you should be able to run: `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`.
    This should be confirmed with the above link.

To setup this repository, follow these steps:
1. Clone this repo into your home directory `~/`: `git clone https://github.com/JacobBas-Coalitioninc/dotfiles.git`
2. Set the clones repo as you curent directory: `cd ~/dotfiles`
3. Run the setup bash script to setup symlinks and plugins: `source init_config.sh`


## How to use

To use this setup all you have to do is open up the Kitty desktop application and type the
`nvim` command within your terminal to open up the neovim editor.

My most used command is `nvim .` which will open up the current directory within `neovim`.
