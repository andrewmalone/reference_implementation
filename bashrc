# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export M2_HOME=/usr/local/apache-maven
export M2=$M2_HOME/bin 
export PATH=$M2:$PATH

export JAVA_HOME=/usr/java/default/jre

alias wlstart='sudo -b -u oracle /opt/oracle/domains/wlsonly/startWebLogic.sh'
alias wlstop='sudo -b -u oracle /opt/oracle/domains/wlsonly/bin/stopWebLogic.sh'
alias wlclear='sudo -b -u oracle rm -rf /opt/oracle/domains/wlsonly/servers/AdminServer/tmp;sudo -b -u oracle rm -rf /opt/oracle/domains/wlsonly/servers/AdminServer/cache'