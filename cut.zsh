#!/bin/zsh

d=${0:a:h}
case $1 in
	t)
		convert 01.png -crop 580x930-0+100 t.png
		exit
		;;
esac

t=`zsh -c ls`
n=`echo $t|wc -l`
str=`echo ${d} | awk -F "/" '{ print $NF }'`
for (( i=1;i<=$n;i++ ))
do
	tt=`echo $t|awk "NR==$i"`
	name=${tt%.*}
	echo $name
        convert $tt -crop 600x930-0+100 ${str}_${name}-crop.png
	#convert $tt -gravity center -crop 800x1400+0+300 $name-crop.png
	rm -rf $tt
done

rm -rf $d/t.png
rm -rf $d/cut.zsh
