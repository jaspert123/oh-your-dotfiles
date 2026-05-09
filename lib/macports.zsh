port_installed=""

function port_command() {
  echo "/opt/local/bin/port"
}

function port_run() {
  sudo $(port_command) $@
}

function port_install_upgrade_formulas() {
  port_install_formulas
  port_upgrade_formulas
}

function port_install_formulas() {
  formulas=$(dotfiles_find_installer "install.macports")

  if [ -n "$formulas" ]; then
    port_check_and_install
    port_installed=$($(port_command) -q installed 2>/dev/null)
    for file in $(dotfiles_find_installer install.macports); do
      port_install "$file"
    done
  fi
}

function port_install() {
  file="$1"
  missing_ports=""
  for port in $(cat "$file"); do
    if ! echo "$port_installed" | grep -q "^ *$port @"; then
      missing_ports+="$port "
    fi
  done
  missing_ports=$(echo "$missing_ports" | xargs)
  if [ -n "$missing_ports" ]; then
    run "installing ports from $file ($missing_ports)" "port_run install $missing_ports"
  fi
}

function port_upgrade_formulas() {
  if [ -f $(port_command) ]; then
    run "updating macports" "port_run selfupdate"
    outdated=$($(port_command) -q outdated 2>/dev/null | awk '{print $1}' | sed -e :a -e '$!N; s/\n/, /; ta')
    if [ -n "$outdated" ]; then
      run "upgrading ports ($outdated)" "port_run upgrade outdated"
    fi
  fi
}

function port_check_and_install() {
  if [ ! -f $(port_command) ]; then
    fail "macports is not installed. Please install MacPorts from https://www.macports.org/install.php and re-run dotfiles_install"
  fi
}
