

# Load all my dotfiles
for file in ~/.{extra,bash_prompt,exports,aliases,osx,tests,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file;

export PATH="$HOME/google-cloud-sdk/bin:$PATH"
