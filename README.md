### Preconditions
* CentOS 7

### Installation
* Download the Oracle Server XE rpm install package for Linux (e.g. oracle-xe-*.x86_64.rpm.zip) from Oracle

> http://download.oracle.com/otn/linux/oracle11g/xe/oracle-xe-11.2.0-1.0.x86_64.rpm.zip

* If necessary, install additional packages and increase the swap file using prepare_centos.sh
* Unzip the downloaded Oracle Server XE rpm install package
* <code>./install.sh &lt;path to oracle rpm&gt;/oracle-xe-*.x86_64.rpm</code>
* add the needed user schemas with: <code>./prepare_user.sh &lt;username&gt; &lt;password&gt;</code>
