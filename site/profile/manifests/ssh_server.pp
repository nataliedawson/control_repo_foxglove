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
		key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCpjF6VjScN4G9rHkvTWY3l4lExSER3LmXtVI3NkJloT72WRgC1PsDA6g8VTq0/4v13u1M+YZ4lCfGLaBPF7qePlvKGbw3HnZ9+oI8X1L88qi6Qf8IMr8HG/QAJIxXq49nwPs8qqRUlweb6vhQpgUD+9auiRfClAOtoEicI3Koi7f7nlhBKKtDfsC5X9+9alGmUN6ZoCXcEY2LdAWUdmWzGxIFVJS3WsWNyyczYlHLaMH30W4ioBdOZ60Fj3DQYyI1S67In6dTwkyPyO19tt6DZDMJbJJqD9DjQ9TckNAfdPpEebHuJBUq5aEq5T8B9n99tsuAuAqxQ3p+17h9YnNjp',
	}  
}
