#!/bin/bash
# Variables
distro=$(lsb_release -sd)
release=$(lsb_release -sr)
distribut=$(lsb_release -si)

case $distribut in
Ubuntu) # Ubuntu LTS Version Supported
    case $release in 
    # Tested with 16.04, 18.04 and 20.04 and information about LSB-Release.
    16.04 | 18.04 | 20.04) sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+$(lsb_release -sc)_all.deb &&
                           sudo dpkg -i zabbix-release_5.0-1+$(lsb_release -sc)_all.deb && 
                           sudo apt-get update && sudo apt-get install zabbix-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
openSuse | openSUSE)
    if [[ "$distribut" == "openSUSE" ]]
    then
        distro=$(lsb_release -sd | awk '{split($0,tmp," "); print tmp[2]}' | sed 's/.$//')
        case $distro in
        # Tumbleweed not testet and information about LSB-Release.
        Tumbleweed) sudo zypper addrepo http://download.opensuse.org/repositories/server:/monitoring:/zabbix/openSUSE_Tumbleweed/server:monitoring:zabbix.repo &&
                    sudo zypper refresh && sudo zypper install zabbix50-agent;;
        *) echo "The version $release of $distro from $distribut is not available.";;
        esac
    elif [[ "$distribut" == "openSuse" ]]
    then
        #openSuse Leap ('Stable Release')
        case $release in
        # Leap 15 tested and information about LSB-Release.
        15.0) sudo zypper addrepo https://download.opensuse.org/repositories/server:monitoring:zabbix/openSUSE_Leap_15.0/server:monitoring:zabbix.repo && 
              sudo zypper refresh && sudo zypper install zabbix50-agent;;
        # Leap 15.1 tested and information about LSB-Release.
        15.1) sudo zypper addrepo https://download.opensuse.org/repositories/server:monitoring:zabbix/openSUSE_Leap_15.1/server:monitoring:zabbix.repo &&
              sudo zypper refresh && sudo zypper install zabbix50-agent;;
        # Leap 15.2 tested and information about LSB-Release. 
        # No Repository available(2020-07-13 [YYYY-MM-DD]) for Zabbix Agent 5.0
        15.2) sudo zypper install zabbix-agent;;
        *) echo "The version $release of $distro from $distribut is not available.";;
        esac
    fi;;  
CentOS) # CentOS LTS Version Supported
    case $release in
    # Version 7 tested and information about LSB-Release.
    7.8.2003) yum install https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm && yum install zabbix-agent;;
    # Version 8 tested and information about LSB-Release.
    8.2.2004) yum install https://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-release-5.0-1.el8.noarch.rpm && yum install zabbix-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
Debian) # Debian LTS Version Supported
    case $release in
    # Tested with Version 9 and 10 and informations about LTS-Release.
    9 | 10) sudo wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1+$(lsb_release -sc)_all.deb && 
            sudo dpkg -i zabbix-release_5.0-1+$(lsb_release -sc)_all.deb && 
            sudo apt-get update && sudo apt-get install zabbix-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
'SUSE LINUX') # SUSE Linux Enterprise Server 11
    case $release in
    11 | 11.1 | 11.2 | 11.3 | 11.4) sudo zypper addrepo http://download.opensuse.org/repositories/server:/monitoring:/zabbix/SLE_11/server:monitoring:zabbix.repo && 
        sudo zypper refresh && sudo zypper install zabbix42-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
SUSE) # SUSE Linux Enterprise Server
    case $release in
    # Version 12 tested and information abaout LSB-Release.
    12 | 12.1 | 12.2 | 12.3 | 12.4 | 12.5) sudo zypper install https://repo.zabbix.com/zabbix/5.0/sles/12/x86_64/zabbix-release-5.0-1.el12.noarch.rpm && sudo zypper refresh && sudo zypper install zabbix-agent;;
    # Version 15 not tested and no information about LSB-release.
    15 | 15.1 | 15.2) sudo zypper install https://repo.zabbix.com/zabbix/5.0/sles/15/x86_64/zabbix-release-5.0-1.el15.noarch.rpm && sudo zypper refresh && sudo zypper install zabbix-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
elementary) # ElementaryOS
    case $release in
    5.1.5) sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+bionic_all.deb &&
           sudo dpkg -i zabbix-release_5.0-1+bionic_all.deb && sudo apt-get update && sudo apt-get install zabbix-agent;;
    *) echo "The version $release of $distro from $distribut is not available.";;
    esac;;
*) echo "The distribution $distro from $distribut is not available in version $release";;
esac
