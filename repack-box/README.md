Go to the vagrant/rpm-test folder and put both repackage/ and repackage-box.sh in rpm-test/, where the Vagrantfile exists. 
To repackage the box with camflow installed in the kernel, run 

./repackage-box.sh

You will see a package.box file in the working directory after the script finishes running. 
Then, you can either add the box to vagrant locally or upload it to vagrant cloud. 
To add to vagrant locally, do 

vagrant box add </path/to/package.box> --name <gave-your-box-a-name>

To upload to vagrant cloud and publish: 
Go to https://vagrantcloud.com, sign into your accout, and upload to one of your existing boxs or creating a create box.