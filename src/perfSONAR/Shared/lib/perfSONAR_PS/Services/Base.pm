package perfSONAR_PS::Services::Base;

use strict;
use warnings;

our $VERSION = 3.3;

use fields 'CONF', 'DIRECTORY', 'ENDPOINT', 'PORT';

=head1 NAME

perfSONAR_PS::Services::Base

=head1 DESCRIPTION

A module that provides basic methods for Services.  This module aims to offer
simple methods for dealing with requests for information, and the related tasks
of interacting with backend storage. 

=head1 API

=cut

use Log::Log4perl qw(get_logger);

=head2 new(\%conf, \%ns)

The accepted arguments may also be ommited in favor of the 'set' functions.

=cut

sub new {
    my ( $class, $conf, $port, $endpoint, $directory ) = @_;

    my $self = fields::new( $class );

    if ( defined $conf and $conf ) {
        $self->{CONF} = \%{$conf};
    }

    if ( defined $directory and $directory ) {
        $self->{DIRECTORY} = $directory;
    }

    if ( defined $port and $port ) {
        $self->{PORT} = $port;
    }

    if ( defined $endpoint and $endpoint ) {
        $self->{ENDPOINT} = $endpoint;
    }

    return $self;
}

=head2 setConf(\%conf)

(Re-)Sets the value for the 'conf' hash. 

=cut

sub setConf {
    my ( $self, $conf ) = @_;
    my $logger = get_logger( "perfSONAR_PS::Services::Base" );

    if ( defined $conf and $conf ) {
        $self->{CONF} = \%{$conf};
    }
    else {
        $logger->error( "Missing argument." );
    }
    return;
}

=head2 setPort($self, $port)

Sets the port value

=cut

sub setPort {
    my ( $self, $port ) = @_;
    my $logger = get_logger( "perfSONAR_PS::Services::Base" );

    if ( defined $port and $port ) {
        $self->{PORT} = $port;
    }
    else {
        $logger->error( "Missing argument." );
    }
    return;
}

=head2 setEndpoint($self, $endpoint)

Sets the endpoint value

=cut

sub setEndpoint {
    my ( $self, $endpoint ) = @_;
    my $logger = get_logger( "perfSONAR_PS::Services::Base" );

    if ( defined $endpoint and $endpoint ) {
        $self->{ENDPOINT} = $endpoint;
    }
    else {
        $logger->error( "Missing argument." );
    }
    return;
}

=head2 setDirectory($self, $directory) 

Sets the directory value.

=cut

sub setDirectory {
    my ( $self, $directory ) = @_;
    my $logger = get_logger( "perfSONAR_PS::Services::Base" );

    if ( defined $directory and $directory ) {
        $self->{DIRECTORY} = $directory;
    }
    else {
        $logger->error( "Missing argument." );
    }
    return;
}

1;

__END__
 
=head1 SYNOPSIS

    use perfSONAR_PS::Services::Base;

    my %conf = ();
    $conf{"METADATA_DB_TYPE"} = "xmldb";
    $conf{"METADATA_DB_NAME"} = "/home/jason/perfSONAR-PS/MP/SNMP/xmldb";
    $conf{"METADATA_DB_FILE"} = "snmpstore.dbxml";
    
    my %ns = (
      nmwg => "http://ggf.org/ns/nmwg/base/2.0/",
      netutil => "http://ggf.org/ns/nmwg/characteristic/utilization/2.0/",
      nmwgt => "http://ggf.org/ns/nmwg/topology/2.0/",
      snmp => "http://ggf.org/ns/nmwg/tools/snmp/2.0/"    
    );
    
    my $self = perfSONAR_PS::Services::Base->new(\%conf, \%ns);

    # or
    # $self = perfSONAR_PS::Services::Base->new;
    # $self->setConf(\%conf);
    # $self->setNamespaces(\%ns);              

=head1 SEE ALSO

L<Exporter>, L<Log::Log4perl>

To join the 'perfSONAR-PS Users' mailing list, please visit:

  https://lists.internet2.edu/sympa/info/perfsonar-ps-users

The perfSONAR-PS subversion repository is located at:

  http://anonsvn.internet2.edu/svn/perfSONAR-PS/trunk

Questions and comments can be directed to the author, or the mailing list.
Bugs, feature requests, and improvements can be directed here:

  http://code.google.com/p/perfsonar-ps/issues/list

=head1 VERSION

$Id$

=head1 AUTHOR

Jason Zurawski, zurawski@internet2.edu

=head1 LICENSE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=head1 COPYRIGHT
 
Copyright (c) 2004-2010, Internet2 and the University of Delaware

All rights reserved.

=cut

# vim: expandtab shiftwidth=4 tabstop=4
