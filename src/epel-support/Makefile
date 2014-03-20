# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

## Download packages from EPEL

EPEL_PKGS = libnet \
	libnet-devel \
	perl-aliased \
	perl-AnyEvent \
	perl-AnyEvent-HTTP \
	perl-Crypt-CBC \
	perl-Crypt-DES \
	perl-Carp-Assert \
	perl-Net-Domain-TLD \
	perl-Net-Daemon \
	perl-Net-Netmask \
	perl-Net-Server \
	perl-DateTime-Format-Builder \
	perl-DateTime-Format-ISO8601 \
	perl-Expect \
	perl-Hash-Merge \
	perl-HTML-Template \
	perl-IO-Interface \
	perl-IPC-DirQueue \
	perl-JSON-XS \
	perl-Log-Dispatch \
	perl-Log-Dispatch-FileRotate \
	perl-Log-Log4perl \
	perl-Mail-Sender \
	perl-Mail-Sendmail \
	perl-MD5 \
	perl-Moose \
	perl-Nagios-Plugin \
	perl-Net-CIDR \
	perl-Regexp-Common \
	perl-Socket-GetAddrInfo \
	perl-Statistics-Descriptive \
	perl-Sys-MemInfo \
	perl-Text-CSV_XS

.PHONY: force RPMS local-config $(EPEL_PKGS)

default: $(HOME)/.rpmmacros rpm-mkdirs $(COMPONENTS) RPMS 
	-yum -y install epel-release-6-8.noarch.rpm
	$(SED) -i 's/^enabled.*/enabled=0/' /etc/yum.repos.d/epel.repo
	$(MAKE) $(EPEL_PKGS)
	-mkdir $(REDHAT.RPMS)/noarch
	$(INSTALL) RPMS/*noarch*rpm $(REDHAT.RPMS)/noarch
	$(INSTALL) RPMS/*$(ARCH)*rpm $(REDHAT.RPMS)/$(ARCH)
	$(MAKE) localrepo

localrepo: local-config
	cd RPMS; createrepo --basedir=. .

local-config: RPMS
	echo "[local]" > RPMS/local
	echo "name='EPEL Local Cache'" >> RPMS/local
	echo "baseurl=file:`pwd`/RPMS" >> RPMS/local
RPMS:
	-mkdir RPMS

$(EPEL_PKGS): 
	yumdownloader --resolve --disablerepo='*' --enablerepo=epel --destdir=RPMS $@

clean::
	/bin/rm -rf RPMS
