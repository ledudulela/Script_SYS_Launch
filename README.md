# Script Launch
Objet: Exécute le lanceur ( .desktop ) dont le nom a été saisi dans une boîte de dialogue 

Dépendances: zenity

![screenshot](https://github.com/ledudulela/Script_SYS_Launch/blob/master/launch.jpg)

--

**Principe:**

* Créer un répertoire dans le HOME et y coller le script launch

* Y créer les fichiers .desktop en leur donnant un nom court (sur 2 caractères par exemple)

* Ajouter au tableau de bord, un nouveau lanceur (ou alors créer un raccourci clavier) pointant sur le script launch

**Utilisation:**

Désormais en cliquant sur ce lanceur (dans le tableau de bord), une boîte de dialogue s'ouvre et vous propose de saisir le nom d'un .desktop , 
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
```

**Conseil:**

La valeur Name doit être identique au nom du fichier.desktop

**Astuce:**

mon raccourci clavier: touche Windows (à droite de la barre espace) et touche X

