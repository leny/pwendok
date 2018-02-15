function vdeploy --description 'vagrant destroy, up and ssh'
	vagrant destroy --force
vagrant up
vagrant ssh
end
