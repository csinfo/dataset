# Repackage Virtual Box with CamFlow Installed
It first vagrants up an existing `Vagrantfile` that contains the host operating system and `CamFlow` provisioning.
Once it is done, it runs the `resolve-issues.sh` to fix some issues and clean up. At last, it will repackage the virtual machine with `CamFlow`.

## Detailed Procedure
1. Go to the `vagrant/rpm-test` (`CamFlow` github) folder and put both `repackage/` and `repackage-box.sh` in `rpm-test/`. 

2. To repackage the box with `CamFlow` installed in the kernel, run 
```
./repackage-box.sh
```

3. You will see a `package.box` file in the working directory after the script finishes running. 
4. You can either add the box to vagrant locally by:
```
vagrant box add </path/to/package.box> --name <box_name>
```
or upload it to vagrant cloud by:
- Go to https://vagrantcloud.com
- Sign into your accout
- Upload to one of your existing boxs or creating a new box.

## Repackage with a new Kernel
You have to manually change the following line in `resolve-issues.sh`:
```
sudo grub2-set-default "Fedora (4.11.6camflow-0.3.3) 25 (Workstation Edition)"
```
By giving it a new kernel name, which can be found by issuing the following command in the virtual box:
```
grep -P "submenu|^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
```
