#!/bin/zsh
case $1 in
	"")	pg=18	;;
	*)	pg=$1	;;
esac
tl=`osascript -e 'tell application "Google Chrome" to get NAME of active tab of first window' | cut -d ' ' -f -1`
ul=`osascript -e 'tell application "Google Chrome" to get URL of active tab of first window'`
ul=`echo ${ul:t} | cut -d = -f 4-`
fn=${tl}_${ul}
hd=${0:a:h}
td=$hd/$ul
mkdir -p $td
echo ${fn}
cd $hd

w=`osascript -e 'tell application "Google Chrome" to get the bounds of the first window' | tr -d ' '`
osascript -e 'tell application "Google Chrome" to activate'
id=`osascript -e 'tell application "Google Chrome" to get id of every window'`
for ((i=1;i<=${pg};i++ ))
do
	osascript -e 'tell application "Google Chrome" to activate'
	if [ $i -le 9 ];then
		f=$td/0${i}.png
	else
		f=$td/${i}.png
	fi
	echo $f
	echo screencapture -R${w} $f
	screencapture -R${w} $f
	sleep 1
	osascript << EOF > /dev/null 2>&1 
	tell application "Google Chrome"
	    activate
	    tell application "System Events"
	        delay 0.3
	        key code 123
	        --tell application "Terminal"
	        tell application "iTerm"
	            activate
	        end tell
	    end tell
	end tell
EOF
	sleep 3
done

rm -rf $ul/.*
apack ${fn}.zip $ul 
rm -rf $ul
