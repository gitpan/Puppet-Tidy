use strict;
use Puppet::Tidy;
use Test::More tests => 1;

# XX: Don't unquote MD5 hashed passwords.
my @output;
my $source = << 'EOF';
user { 'abcuser':
     ensure => present,
     comment => 'User',
     home => '/home/abcuser',
     password => '$1$h3e22.7M$Nb22222222345678990443',
}
EOF

my @should_be_output = << 'EOF';
user { 'abcuser':
     ensure => present,
     comment => 'User',
     home => '/home/abcuser',
     password => '$1$h3e22.7M$Nb22222222345678990443',
}
EOF

Puppet::Tidy::puppettidy(source => $source, destination => \@output);
is_deeply(@output, @should_be_output, "Don't unquote password lines");
