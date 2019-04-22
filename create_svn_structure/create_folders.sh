#!/bin/bash
# expendable dialog for folder creation

folders_nato="
alpha
bravo
charlie
delta
echo
foxtrot
golf
hotel
india
juliet
kilo
lima
mike
november
oscar
papa
quebec
romeo
sierra
tango
uniform
victor
whiskey
xray
yankee
zulu"

folders_digits="
zero
one
two
three
four
five
six
seven
eight
nine
ten"

folders_scientists="
aho
babbage
backus
bauer
beck
bell
beyer
bjarne
boehm
booch
boole
brooks
chen
chomsky
cray
dahl
demarco
dijkstra
fagan
feigenbaum
floyd
fowler
gamma
goedel
gosling
guttag
hamming
hoare
hollerith
huffman
jackson
kay
kernighan
knuth
lamport
lee
leibnitz
lovelace
minsky
neuman
parnas
petri
ritchie
rumbaugh
sethi
shannon
tanenbaum
tarski
tichy
torvalds
turing
ulam
ullman
vlissides
wang
weizenbaum
wirth
zuse"

folders_custom="
aho
babbage
backus
bauer
beck
bell
bjarne
boole
brooks
chomsky
cray
dijkstra
floyd
gamma
guttag
hamming
huffman
jackson
kay
lee
leibnitz
lovelace
minsky
neuman
petri
ritchie
shannon
tanenbaum
torvalds
turing
ulam
wang
weizenbaum
zuse
"

script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
base="$scriptpath/$1"

folders=""


dialog --backtitle SVN-Folders --title "SVN Folders" --yesno "Create 'custom' folders only (y/n)?" 15 60
custom=${?}

if [ "$custom" -eq "0" ]
  then
	folders=$folders_custom
  else
	dialog --backtitle SVN-Folders --title "SVN Folders" --yesno "Create NATO-code-folders [26] (y/n)?" 15 60
	nato=${?}

	dialog --backtitle SVN-Folders --title "SVN Folders" --yesno "Create Scientist-folders [58] (y/n)?" 15 60
	scientists=${?}

	dialog --backtitle SVN-Folders --title "SVN Folders" --yesno "Create Digit-folders [10] (y/n)?" 15 60
	digit=${?}

	dialog --backtitle SVN-Folders --title "SVN Folders" --yesno "Create 'staff' folder (y/n)?" 15 60
	staff=${?}
fi


if [ "$nato" -eq "0" ]
  then
	folders=$folders_nato
fi
if [ "$scientists" -eq "0" ]
  then
	folders=$folders" "$folders_scientists
fi
if [ "$digit" -eq "0" ]
  then
	echo $folders_digits
echo $folders
	folders=$folders" "$folders_digits
fi
if [ "$staff" -eq "0" ]
  then
	echo "Creating group folder ${base%/}/staff"
	mkdir "${base%/}/staff"
fi

subfolders="
comments
solutions
workspace"


cd $base

for folder in $folders
do	
	echo "Creating group folder $folder"
	mkdir "${base%/}/$folder"
	for subfolder in $subfolders
	do
		echo "... creating ${base%/}/$folder/$subfolder"
		mkdir "${base%/}/$folder/$subfolder"
	done
done
echo "all done :)"
