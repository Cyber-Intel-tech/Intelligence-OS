#!/bin/bash

echo "🔵 Inizio installazione di GhostSIGINT OS..."

# Formattazione della partizione
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

# Installazione del sistema base
pacstrap /mnt base linux linux-firmware nano

# Generazione fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Entrare nel sistema
arch-chroot /mnt <<EOF
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc
echo "LANG=it_IT.UTF-8" > /etc/locale.conf
echo "GhostSIGINT" > /etc/hostname
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
EOF

echo "✅ Installazione completata!"
# Intelligence-OS
