#-------------------------------------------------------------------------------
# Robert's dotfiles Makefile
# - Creates symlinks for a thin .bashrc to reference and source these files
# - Makes things super-painless, too. To install the dotfiles on a new
#   station, you just 'git clone rlp70/dotfiles .' and then hit 'make'. Then
#   you can just edit, push, & update without having to mess with any dotfiles
#   in the home directory.
#
# Credits:
# I first saw something like this in Jeff Frazelle's dotfiles repo.
# - github.com/jessfraz/dotfiles/Makefile
#-------------------------------------------------------------------------------
#
# * TODOs [0/2]: 
#   - [ ] Need a way to move the dotfiles directory after an install.
#     - We could just do an uninstall or a pure overwrite, but I'd rather take a
#       look at the filetype to see if it's a symlink. If it is, then go ahead
#       and retarget it. Otherwise, save it with the ".old" extension
#   - [ ] Fix the help system
#     - You might want to start with trying to understanding it ya pasta chef...
#
#-------------------------------------------------------------------------------

.PHONY: all
.PHONY: dotfiles
.PHONY: help

all: dotfiles

# Make the symlink for each file.
#
# If there is already a file there, it will save that file with a ".old" 
# extension for you to look at later.
dotfiles:
	for file in \
        $(shell find $(CURDIR) -name ".*" \
                               -not -name ".git" \
                               -not -name ".gitignore" \
        ); \
        do \
	  f=$$(basename $$file); \
	  if [ -f $(HOME)/$$f ] ; then \
	    if [ -h $(HOME)/$$f ] ; then \
	      continue; \
	    else \
	      mv $(HOME)/$$f $(HOME)/$$f.old; \
	    fi; \
	  fi; \
	  ln -sfn $$file $(HOME)/$$f;\
	done;

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
