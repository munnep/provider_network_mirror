Vagrant.configure("2") do |config|


    config.vm.box = "alvaro/bionic64"

    config.vm.define "nginx" do |nginx|
        config.vm.hostname = "nginx"
        config.vm.network "private_network", ip: "192.168.56.33"
    
        config.vm.provision "shell", path: "vagrant_scripts/install_nginx.sh"
        config.vm.provision "shell", path: "vagrant_scripts/install_terraform.sh"
        config.vm.provision "shell", path: "vagrant_scripts/configure_terraform_mirror_network.sh", privileged: false
        config.vm.provision "shell", path: "vagrant_scripts/configure_nginx.sh"
    end

    config.vm.define "tf" do |tf|
      config.vm.hostname = "tf"
      config.vm.network "private_network", ip: "192.168.56.34"
  
      config.vm.provision "shell", path: "vagrant_scripts/install_terraform.sh"
      config.vm.provision "shell", path: "vagrant_scripts/configure_terraform.sh", privileged: false
    end

  end