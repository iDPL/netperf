%define real_name Net-Netmask

Name:    perl-Net-Netmask
Version: 1.9015
Release: 1%{?dist}
Summary: Net::Netmask - parse, manipulate and lookup IP network block 

Group:   Development/Libraries
License: Artistic 2.0 or LGPLv2
URL:     http://search.cpan.org/dist/Net-Netmask/

Source0:   http://www.cpan.org/modules/by-module/RPC/%{real_name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n) 

BuildRequires: perl(ExtUtils::MakeMaker)

%description
Net::Netmask parses and understands IPv4 CIDR blocks. It's built with an object-oriented interface. Nearly all functions are methods that operate on a Net::Netmask object.

There are methods that provide the nearly all bits of information about a network block that you might want.

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
