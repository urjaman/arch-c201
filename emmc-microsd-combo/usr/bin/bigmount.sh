#!/bin/sh
mount /dev/$1 /home/urjaman/BigData
mount --bind /home/urjaman/BigData/kicad-packages3d /usr/share/kicad/modules/packages3d
mount --bind /home/urjaman/BigData/texmf-dist /usr/share/texmf-dist
mount --bind /home/urjaman/BigData/share-soundfonts /usr/share/soundfonts
mount --bind /home/urjaman/BigData/share-neverball /usr/share/neverball
mount --bind /home/urjaman/BigData/share-gtk-doc /usr/share/gtk-doc
mount --bind /home/urjaman/BigData/share-doc /usr/share/doc
mount --bind /home/urjaman/BigData/pacman-pkg /var/cache/pacman/pkg
