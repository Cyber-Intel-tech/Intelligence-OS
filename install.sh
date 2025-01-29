#!/bin/bash

echo "🚀 Installazione di Intelligence-OS in corso..."

# Controllo se l'utente è root
if [ "$EUID" -ne 0 ]; then
  echo "⚠️ Esegui questo script come root (sudo ./install.sh)"
  exit 1
fi

# Abilita i repository essenziali
echo "🔄 Aggiornamento del sistema..."
pacman -Syu --noconfirm

# Installa pacchetti base
echo "📦 Installazione pacchetti di base..."
pacman -S --noconfirm git base-devel linux linux-firmware nano networkmanager grub os-prober sudo

# Abilita NetworkManager per la connessione a Internet
echo "🌐 Configurazione NetworkManager..."
systemctl enable NetworkManager
systemctl start NetworkManager

# Configurazione dell'hostname
echo "🖥️ Configurazione del nome host..."
echo "Intelligence-OS" > /etc/hostname

# Configurazione della lingua
echo "🌍 Configurazione della lingua..."
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Creazione utente "davide"
echo "👤 Creazione utente..."
useradd -m -G wheel -s /bin/bash davide
echo "Imposta una password per l'utente davide:"
passwd davide

# Abilita sudo per l'utente
echo "🛠️ Configurazione sudo..."
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Installazione di GRUB per il boot
echo "🖥️ Installazione di GRUB..."
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Installazione tool SIGINT e GEOINT
echo "🛰️ Installazione dei tool di intelligence..."
pacman -S --noconfirm wireshark-qt aircrack-ng nmap python-pip
pip install geopandas folium scapy

# Clonazione di Intelligence-OS (se necessario)
echo "📥 Clonazione del repository Intelligence-OS..."
git clone https://github.com/Cyber-Intel-tech/Intelligence-OS.git ~/Intelligence-OS

echo "✅ Installazione completata! Riavvia il sistema per applicare le modifiche."
