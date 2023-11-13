dev:
  trap 'kill %1; kill %2' SIGINT
  typst watch main.typ &
  sleep 1 && zathura main.pdf

