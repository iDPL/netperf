%define real_name Net-Daemon

Name:    perl-Net-Daemon
Version: 0.48
Release: 1%{?dist}
Summary: Net::Daemon - Perl extension for portable daemons

Group:   Development/Libraries
License: Artistic 2.0 or LGPLv2
URL:     http://search.cpan.org/dist/Net-Daemon/

Source0:   http://www.cpan.org/modules/by-module/RPC/%{real_name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n) 

BuildRequires: perl(ExtUtils::MakeMaker)

%description
Net::Daemon is an abstract base class for implementing portable server applications in a very simple way. The module is designed for Perl 5.005 and threads, but can work with fork() and Perl 5.004.

The Net::Daemon class offers methods for the most common tasks a daemon needs: Starting up, logging, accepting clients, authorization, restricting its own environment for security and doing the true work. You only have to override those methods that aren't appropriate for you, but typically inheriting will safe you a lot of work anyways.

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
%{perl_vendorarch}/auto/Net/*
