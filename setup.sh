#!/bin/bash

echo "🔧 Configurazione di Intelligence-OS in corso..."

# Controllo se l'utente è root
if [ "$EUID" -ne 0 ]; then
  echo "⚠️ Esegui questo script come root (sudo ./setup.sh)"
  exit 1
fi

# Aggiornamento del sistema
echo "🔄 Aggiornamento dei pacchetti..."
pacman -Syu --noconfirm

# Installazione pacchetti SIGINT e GEOINT
echo "🛰️ Installazione dei tool di intelligence..."
pacman -S --noconfirm wireshark-qt aircrack-ng nmap python-pip
pip install geopandas folium scapy

# Creazione delle directory per i dati intelligence
echo "📂 Creazione delle cartelle per i dati..."
mkdir -p ~/SIGINT_data ~/GEOINT_data ~/CyberIntel

# Installazione di altre utility avanzate (opzionale)
echo "📦 Installazione di utilities aggiuntive..."
pacman -S --noconfirm tmux htop neofetch ranger

# Messaggio di completamento
echo "✅ Intelligence-OS è stato configurato correttamente! Riavvia per completare la configurazione."
