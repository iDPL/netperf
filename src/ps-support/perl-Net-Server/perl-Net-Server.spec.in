%define real_name Net-Server

Name:    perl-Net-Server
Version: 0.94
Release: 1%{?dist}
Summary: is an extensible, generic Perl server engine. Net::Server combines the good properties from Net::Daemon 

Group:   Development/Libraries
License: Artistic 2.0 or LGPLv2
URL:     http://search.cpan.org/dist/Net-Server/

Source0:   http://www.cpan.org/modules/by-module/RPC/%{real_name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n) 
BuildArch: noarch

BuildRequires: perl(ExtUtils::MakeMaker)
BuildRequires: perl(IO::Socket)
BuildRequires: perl(POSIX)
BuildRequires: perl(Socket)

%description
The RPC::XML package is an implementation of XML-RPC. The module provides
classes for sample client and server implementations, a server designed as an
Apache location-handler, and a suite of data-manipulation classes that are 
used by them.

%prep
%setup -qn %{real_name}-%{version}

chmod -c -x t/* 

#Filter unwanted Provides:
#  RPC::XML::Method creates two entries for some reason?
cat << \EOF > %{real_name}-prov
#!/bin/sh
%{__perl_provides} $* |\
  %{__sed} -e '/perl(RPC::XML::Method)$/d'
EOF

%define __perl_provides %{_builddir}/%{real_name}-%{version}/%{real_name}-prov
chmod +x %{__perl_provides}

%build
perl Makefile.PL INSTALLDIRS="vendor" PREFIX="%{_prefix}"
make %{?_smp_mflags}

%install
rm -rf %{buildroot}

make pure_install PERL_INSTALL_ROOT=%{buildroot}
find %{buildroot} -type f -name .packlist -exec rm -f {} ';'

%{_fixperms} %{buildroot}/*

%check
make test

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_mandir}/man3/Net*
%{perl_vendorlib}/Net/*
