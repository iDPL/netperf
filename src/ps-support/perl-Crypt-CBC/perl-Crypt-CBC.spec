%define real_name Crypt-CBC

Name:    perl-Crypt-CBC
Version: 2.33
Release: 1%{?dist}
Summary: Crypt::CBC - Encrypt Data with Cipher Block Chaining Mode 

Group:   Development/Libraries
License: Artistic 2.0 or LGPLv2
URL:     http://search.cpan.org/dist/Crypt-CBC/

Source0:   http://www.cpan.org/modules/by-module/RPC/%{real_name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n) 

BuildRequires: perl(ExtUtils::MakeMaker)
BuildRequires: perl(Digest::MD5)

%description
This module is a Perl-only implementation of the cryptographic cipher block chaining mode (CBC). In combination with a block cipher such as DES or IDEA, you can encrypt and decrypt messages of arbitrarily long length. The encrypted messages are compatible with the encryption format used by the OpenSSL package.

To use this module, you will first create a Crypt::CBC cipher object with new(). At the time of cipher creation, you specify an encryption key to use and, optionally, a block encryption algorithm. You will then call the start() method to initialize the encryption or decryption process, crypt() to encrypt or decrypt one or more blocks of data, and lastly finish(), to pad and encrypt the final block. For your convenience, you can call the encrypt() and decrypt() methods to operate on a whole data value at once.
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
%{_mandir}/man3/Crypt*
%{perl_vendorlib}/Crypt/*
%{perl_vendorarch}/auto/Crypt/*
