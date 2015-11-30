# Script Launch
Objet: Exécute le lanceur ( .desktop ) dont le nom a été saisi dans une boîte de dialogue 

Dépendances: zenity

![screenshot](https://github.com/ledudulela/Script_SYS_Launch/blob/master/launch.jpg)

--

**Principe:**

* Créer un répertoire Launch dans le $HOME et y coller le script launch.sh (il peut également se trouver dans /usr/local/bin)

* Y créer les fichiers .desktop en leur donnant un nom court (sur 2 caractères par exemple)

* Créer un nouveau lanceur (dans le tableau de bord ou en raccourci clavier) pointant sur le script launch.sh

**Utilisation:**

Désormais en exécutant sur ce lanceur (tableau de bord ou raccourci clavier), une boîte de dialogue s'ouvre et vous propose de saisir le nom d'un .desktop , 
le script se chargera d'exécuter l'application correspondante.

Pour résumer, ça sert à exécuter une application en tapant 2 lettres.

**Exemple de fichier .desktop (ca.desktop) :**
```
[Desktop Entry]
Encoding=UTF-8
Name=ca
Comment=Calculatrice
Exec=gnome-calculator
Terminal=false
Type=Application
Icon=accessories-calculator
StartupNotify=true
NoDisplay=true 
Path=/
```

**Conseil:**

La valeur Name doit être identique au nom du fichier.desktop

**Astuce:**

mon raccourci clavier: touche Windows (à droite de la barre espace) et touche X

**Rappel:**

Lorsqu'il est placé dans le répertoire /usr/local/bin , le script doit se nommer launch (sans extension) et être rendu exécutable.

**Historique:**

version 1.4
- le script recherche également le lanceur dans les répertoires $HOME/Bureau et $HOME/Lanceurs ( en plus des répertoires
 $PWD (le répertoire du script) , $HOME/.local/share/applications , /usr/local/share/applications , /usr/share/applications )

version 1.3
- possibilité de lancer le script en ligne de commandes avec 2 arguments.

$ launch nom_appli rep_de_travail

version 1.2
- possibilité de lancer le script en ligne de commandes avec 1 argument.

$ launch nom_appli


