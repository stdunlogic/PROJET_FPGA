# PROJET_FPGA
Le projet consiste à controller un moteur pas à pas en fonction de la distance mesurée par un capteur Ultrasons en VHDL avec un FPGA.
Vous trouverez dans ce dépot deux codes vhdl
- pwm: pour le moteur pas à pas, j'ai deux switches pour controler le vitesse de rotation et une switche également pour le controle du sens de rotation.
- capteur: pour pouvoir génerer les signaux nécessaires pour déclancher une mésure, ainsique le calcul pour pouvoir avoir la distance en cm.
Pour l'affichage de la distance mesurée par le capteur j'ai utilisé les afficheurs 7-segmenst de ma carte FPGA et çette partie a été faite en blockdiagram. L'interfaçage entre le capteur et le moteur a été également fait en Blockdiagram.
