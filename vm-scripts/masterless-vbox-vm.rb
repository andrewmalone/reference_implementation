machine.vm.provider :virtualbox do |vb, override|

  alias_name      = alias_name.split('-').last
  hostname        = "#{alias_name}.#{settings[:virtualbox][:domain_name]}"
  override.vm.box = "enterprisemodules/centos-7.2-x86_64-puppet"

  vb.customize ["modifyvm", :id, "--memory", settings[:memory]]
  vb.customize ["modifyvm", :id, "--name", alias_name]
  vb.customize ["modifyvm", :id, "--cpus", settings[:num_cpus]]
  vb.customize ["modifyvm", :id, "--ioapic", "on"]
  vb.customize ["modifyvm", :id, "--nic3", "intnet"]

  override.vm.hostname = hostname
  override.vm.network :private_network, ip: settings[:virtualbox][:priv_ipaddress]#, hostsupdater: "skip"
  override.vm.network :forwarded_port, guest: 7001, guest_ip:"10.10.10.30", host: 7001

  override.vm.provision :shell, :path => "vm-scripts/setup_puppet.sh"
  #
  # And run puppet
  #
  override.vm.provision :shell, :inline => "puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp"

  override.vm.provision :shell, :inline => <<-SHELL
    # install maven
    wget http://mirrors.ibiblio.org/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
    tar xvf apache-maven-3.3.9-bin.tar.gz
    mv apache-maven-3.3.9  /usr/local/apache-maven
    cp /vagrant/bashrc ~/.bashrc
    cp /vagrant/bashrc /home/oracle/.bashrc
    cp /vagrant/bashrc /home/vagrant/.bashrc
    source ~/.bashrc

    # install node, ruby and sass
    yum -y update
    # gem install sass
    yum -y install epel-release
    yum install -y nodejs
    npm install -g grunt-cli

  SHELL

end
