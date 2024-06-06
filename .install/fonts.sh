#!/usr/bin/env bash
# Font installation instructions adapted from "How to Install Nerd Fonts on Linux"
# by Captain Salem, https://www.geekbits.io/how-to-install-nerd-fonts-on-linux/

declare -a fonts=(
	JetBrainsMono
)

version='3.2.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv

