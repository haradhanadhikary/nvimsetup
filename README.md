# How to migrate from packer to lazy and set-up nvim using Lazy.nvim 

### This set-up will help you to migrate from packer to lazy to install plugins in your nvim set-up
### First look into init.lua and then add your preferable plugins as I discussed in my video <https://www.youtube.com/watch?v=wh22j_sHtQQ>

Also follow my previous youtube video on neovim:

[How to #install and #configure #neovim on #MacOS using #packer.nvim](https://www.youtube.com/watch?v=37LTZoK17XU&t=36s)

[Plugins for #nvim to use #colorscheme](https://www.youtube.com/watch?v=9fDuFwlT7cA&t=38s)

[30+ #Amazing #neovim #plugins that make your #programming experience amazing](https://www.youtube.com/watch?v=7Whw9qFRhpQ&t=187s)

[Unveiling the #Secrets of a Complete #neovim #Setup (#plugins and #keymaps) in English](https://www.youtube.com/watch?v=NXBprzIbulQ)

[How to #transparent #neovim window using plugins](https://www.youtube.com/watch?v=CQfIUCOVGsw)

[Why #migration from #packer to #lazy in neovim explained by Bong Panda](https://www.youtube.com/watch?v=JrjTf5-ARO4)

[My GitHub Repository for my set-up](https://github.com/haradhanadhikary/nvimsetup/tree/main)

Install hyperfine on MacOS: 

> brew install hyperfine



On Ubuntu OS: 
>sudo apt-get install hyperfine

Command to check status time: 
>nvim --startuptime time-packer.log time-packer.log

>nvim --startuptime time-lazy.log time-lazy.log


If lsp language server failed to install some language server then first install pyright using following command:
for MacoS:

> brew install pyright

for ubuntu:

> sudo apt-get install pyright


and add "neovim/nvim-lspconfig" as a dependencies of mason.lua file then save and quite and open again

