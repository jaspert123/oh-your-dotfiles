source "${0:a:h}/homebrew.zsh"
source "${0:a:h}/macports.zsh"
BREW_PATH=""
if [[ ":$PATH:" != *":$HOMEBREW_PREFIX/bin:"* ]]; then
  BREW_PATH="${HOMEBREW_PREFIX}/bin:"
fi
if [[ ":$PATH:" != *":$HOMEBREW_PREFIX/sbin:"* ]]; then
  BREW_PATH="${BREW_PATH}${HOMEBREW_PREFIX}/sbin:"
fi
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
  BREW_PATH="${BREW_PATH}/usr/local/bin:"
fi
if [[ ":$PATH:" != *":/usr/local/sbin:"* ]]; then
  BREW_PATH="${BREW_PATH}/usr/local/sbin:"
fi
if [ ! -z "$BREW_PATH" ]; then
  export PATH="${BREW_PATH}${PATH}"
fi

MACPORTS_PATH=""
if [[ ":$PATH:" != *":${MACPORTS_PREFIX}/bin:"* ]]; then
  MACPORTS_PATH="${MACPORTS_PREFIX}/bin:"
fi
if [[ ":$PATH:" != *":${MACPORTS_PREFIX}/sbin:"* ]]; then
  MACPORTS_PATH="${MACPORTS_PATH}${MACPORTS_PREFIX}/sbin:"
fi
if [ -n "$MACPORTS_PATH" ]; then
  export PATH="${MACPORTS_PATH}${PATH}"
fi
