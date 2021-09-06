pyclean () {
		find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

_fzf_compgen_path() {
		fd . "$1"
}

_fzf_compgen_dir() {
		fd --type d . "$1"
}


