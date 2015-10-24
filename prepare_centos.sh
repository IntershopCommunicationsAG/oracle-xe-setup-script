# increase swap (needed for Oracle)
dd if=/dev/zero of=/swapfile bs=1024 count=2097152
mkswap /swapfile
swapon /swapfile

# install missing programs
sudo yum -y install unzip
sudo yum -y install libaio
sudo yum -y install bc
