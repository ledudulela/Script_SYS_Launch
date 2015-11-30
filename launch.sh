#!/bin/bash
# auteur : ledudulela
# version: 1.4
# màj : 2015-11-30 19:50 
# objet: lance un fichier.desktop se trouvant dans le répertoire du script (cf xdg-open OU gtk-launch)
# dépendances: zenity
#
# principe:
# *********
# le script se lance via un lanceur (bureau, tableau de bord, touche de raccourci).
# une boite de dialogue s'ouvre et demande de saisir le nom du fichier.desktop (sans l'extension)
# le script recherche le fichier.desktop et l'exécute
#
# exemples:
# *********
# ff (lance firefox si le fichier ff.desktop existe dans le repertoire du script et pointe vers firefox)
# firefox (lance firefox si le fichier firefox.desktop existe dans un repertoire "share/applications")
# fm $HOME (lance le gestionnaire de fichiers dans le répertoire de l'utilisateur)
# ged $HOME/Raccourcis/launch.desktop (lance gedit et ouvre le fichier launch.desktop se trouvant dans le répertoire Raccourcis)
# ged $PWD/launch.desktop  (lance gedit et ouvre le fichier launch.desktop se trouvant dans le répertoire du script)
# thb --addressbook (lance le carnet d'adresses de thunderbird)
#
# remarques:
# **********
# le script cherche le fichier.desktop dans les répertoires suivants:
# $PWD (le répertoire du script)
# $HOME/.local/share/applications
# $HOME/Bureau,$HOME/Lanceurs,$HOME/Launchers,$HOME/Raccourcis
# /usr/local/share/applications
# /usr/share/applications 
#
# ligne de commandes:
# *******************
# bien que ce ne soit pas sa fonction première, le script accepte deux paramètres en ligne de commandes
# le premier: nom court du fichier.desktop (sans le .desktop)
# le second (optionnel): répertoire de travail, dans lequel le script ira chercher le fichier.desktop
# exemple: launch appli /tmp
#
# exemple d'un fichier xy.desktop pour l'application "monappli"
# ****************************************************************
# [Desktop Entry]
# Encoding=UTF-8
# Version=1.0
# Type=Application
# Name=xy 	(doit correspondre au nom du fichier.desktop lorsqu'il se trouve dans le repertoire du script)
# GenericName=monappli
# Comment=Lanceur de mon application
# Icon=system-run
# Exec=chemin_du_programme_monappli
# Path=repertoire_de_travail 	(optionnel)
# NoDisplay=false 	(optionnel)
#
# ----------------------------------------------------------------------------------------
currentDir=$(dirname "$0")
workingDir=''
#zenity --info --text="$currentDir"
#dataFile="$currentDir/launch.dat"
dataFile="/tmp/launch.dat"
if [ -z $1 ]; then # teste si le param 1 est vide
	lastEntry=''
	if [ -f "$dataFile" ]; then # teste si le fichier existe
		lastEntry=`cat "$dataFile"`
	fi

	txtEntry=$(zenity --entry --entry-text="$lastEntry" --text="Entrez le nom du lanceur à exécuter (sans .desktop) :" --title="Lanceur" --width=400 --height=40 2>/dev/null)
	if [ $? == 1 ]; then # teste si le bouton [Annuler] a été cliqué
		exit 10
	else
		if [ ${#txtEntry} == 0 ]; then  # teste si la chaine est vide
			zenity --info --text="Paramètre non valide."
			exit 20
		fi
	fi
else
	txtEntry=$1
	if [ -z $2 ]; then # teste si le param 2 est vide
		workingDir=''
	else
		workingDir=$2
	fi
fi

# ---------------------------------------------------
fileName=$(echo "$txtEntry" | awk -F " " '{print $1}') # espace sépare le fileName des arguments
p=${#fileName} # nbr de caracteres de $fileName
args=${txtEntry:$p} # la fin de la chaine à partir du caractere n° $p
args=${args//\$PWD/$currentDir} # si les arguments contiennent la chaine $PWD alors celle-ci est remplacée par le répertoire du script
#zenity --info --text="${fileName}_${args}"

# ---------------------------------------------------
launcherPath=''

filePath="/usr/share/applications/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="/usr/local/share/applications/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="$HOME/.local/share/applications/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="$HOME/Bureau/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="$HOME/Raccourcis/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="$HOME/Launchers/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="$HOME/Lanceurs/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

filePath="${currentDir}/${fileName}.desktop"
if [ -f ${filePath} ]; then
	launcherPath=${filePath}
fi

if [ -z ${workingDir} ]; then # teste si la chaine est vide
	filePath="${fileName}.desktop"
	if [ -f ${filePath} ]; then
		launcherPath=${filePath}
	fi
else
	filePath="${workingDir}/${fileName}.desktop"
	if [ -f ${filePath} ]; then
		launcherPath=${filePath}
	fi
fi

#fileName=$(basename "$filePath") 
#zenity --info --text="${filePath} \n ${launcherPath}"

# ---------------------------------------------------
if [ -z ${launcherPath} ]; then # teste si la chaine est vide
	if [ ${txtEntry} = 'help' -o ${txtEntry} = 'aide' ]; then
		zenity --info --text="Aide: \n Le séparateur d'arguments est l'espace."
	else
		zenity --error --text="Le lanceur - ${txtEntry} - est introuvable ou non valide."
	fi
else
	cmdLine=`sed -nr 's/Exec=(.*)$/\\1/p' ${launcherPath}` # extrait la chaine se trouvant après Exec= 
	cmdLine=$(echo "$cmdLine" | awk -F " %" '{print $1}') # supprime tout ce qui se trouve à partir caractere %
	#zenity --info --text="${cmdLine}${args}"
	eval "${cmdLine}${args}" # ajoute les arguments
	echo "$txtEntry" > "$dataFile"
fi

# ---------------------------------------------------
exit 0

