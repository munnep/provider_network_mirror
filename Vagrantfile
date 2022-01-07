Vagrant.configure("2") do |config|

    config.vm.box = "alvaro/bionic64"

    config.vm.define "nginx" do |nginx|
        nginx.vm.hostname = "nginx"
        nginx.vm.network "private_network", ip: "192.168.56.33"
    
        nginx.vm.provision "shell", path: "vagrant_scripts/install_nginx.sh"
        nginx.vm.provision "shell", path: "vagrant_scripts/install_terraform.sh"
        nginx.vm.provision "shell", path: "vagrant_scripts/configure_terraform_mirror_network.sh", privileged: false
        nginx.vm.provision "shell", path: "vagrant_scripts/configure_nginx.sh"
        nginx.vm.provision "shell", path: "vagrant_scripts/configure_ca_certificate.sh"
    end

    config.vm.define "tf" do |tf|
      tf.vm.hostname = "tf"
      tf.vm.network "private_network", ip: "192.168.56.34"
  
      tf.vm.provision "shell", path: "vagrant_scripts/configure_ca_certificate.sh"
      tf.vm.provision "shell", path: "vagrant_scripts/install_terraform.sh"
      tf.vm.provision "shell", path: "vagrant_scripts/configure_terraform.sh", privileged: false
    end

  end
