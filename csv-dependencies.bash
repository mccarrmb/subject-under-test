# Installs CSVLint
csvlint_version='csvlint-v0.2.0-linux-amd64'
wget "https://github.com/Clever/csvlint/releases/download/0.2.0/$csvlint_version.tar.gz"
tar xvzf "$csvlint_version.tar.gz"
sudo mv "$csvlint_version/csvlint" "/usr/local/sbin/"
