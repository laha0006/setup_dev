#!/usr/bin/env bash

apt_update_install() {
	echo "update && upgrade ..."
	sudo apt update && apt upgrade -y

	echo "Installing ripgrep unzip git xclip tmux stow"
	sudo apt install ripgrep unzip git xclip tmux stow -y

	echo "installing ninja-build gettext cmake curl build-esentail"
	sudo apt install ninja-build gettext cmake curl build-essential -y

	echo "Installing zsh"
	sudo apt install zsh -y

	echo "Installing libssl-dev, and pkg-config"
	sudo apt install libssl-dev pkg-config -y
}

build_neovim_source() {
	echo "building neovim from source..."
	git clone https://github.com/neovim/neovim
	cd neovim
	git checkout v0.10.4
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}

setup_tmux_package_manager() {
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


install_fnm_node_lts() {
	echo "installing fnm, and node 22"
	cd ~
	curl -o- https://fnm.vercel.app/install | bash
	source ~/.bashrc
	fnm install --lts
}

install_global_npm() {
	npm install -g prettier
	npm install -g @fsouza/prettierd	
} 

setup_config() {
	cd ~
	git clone https://github.com/laha0006/.dotfiles.git
	cd .dotfiles
	stow .
	cd ~
}

rustup() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}


apt_update_install
setup_config
build_neovim_source
install_fnm_node_lts
install_global_npm
setup_tmux_package_manager
rustup
echo "Complete!"
echo "Change to zsh! RESTART TERMINAL"
chsh -s $(which zsh)
