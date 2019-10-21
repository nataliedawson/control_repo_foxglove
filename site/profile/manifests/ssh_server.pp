class profile::ssh_server {
	package {'openssh-server':
		ensure => present,
	}
	service { 'sshd':
		ensure => 'running',
		enable => 'true',
	}
	ssh_authorized_key { 'root@master.puppet.vm':
		ensure => present,
		user   => 'root',
		type   => 'ssh-rsa',
		key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCmAmgS5czzx+ruGcP0pwurj658T9QgRkEK/8YD7IIGPztMZ0rpvnnjkP07LNjGkbYmfHifg7NdFha8QEKflmN1dySYq4k4+Bc2FnWjCwLW0HjW57nUTGpnOmBr5gHqsdangqReiGIOwUtI1jyoOMYw1uB7yBZCcqOXnXQ4rigouSfKlTgTEDZUx4cqSwifEi5U0lax2ddAKCWxoIAYrEG8rn7lfF5ezsHLWQi1dG4WSjsyFclFlm+kusnbIhkcoAZkczeSc9XBisTAuJAwyDDMazuouF3qC9n10MjeXwc+1CjcFshnizgwGCQay5Q6XRn4AnPgaA6sf4yXT8L8gxtH',
	}  
}
