# the purpose of this bash file is to settup the terminal to 
# interact with the config files that are configured within the directory

# creating symbolic links to these config files within the appropriate folders
for dir in ./*
	do 
		# checking to see if the input object is a directory
		if [[ -d "${dir}" ]]; then
			# removing unwanted characters fromt he directory string
			echo "${dir}" | sed "s/.\///" | read formatted_dir

			# linking the folders to the .config directory; 
			# forcing an update if the file already exists
			ln -sf $PWD/${formatted_dir} ~/.config/${formatted_dir}

			# printing out the success statement
			echo "linked '$PWD/${formatted_dir}' to '~/.config' as '~/.config/${formatted_dir}'"
		fi
	done

# making sure that plug install runs for neovim so that extensions can be installed
nvim +"PlugInstall --sync" +qa
