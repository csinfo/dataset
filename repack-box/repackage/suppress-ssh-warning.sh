# this command is dependent on your OS (this works for Mac OS )
 sed -i '' 's#config.vm.box = "jhcook/fedora25"#  \
 config.vm.box = "jhcook/fedora25" \
 config.ssh.username = "vagrant"  \
 config.ssh.password = "vagrant"  \
 config.ssh.insert_key = false#' Vagrantfile 
