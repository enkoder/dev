If your console font is tiny ([HiDPI][7] systems), set a new font.

    $ setfont sun12x22

Connect to the Internet.

Verify that the [system clock is up to date][8].

    $ timedatectl set-ntp true

This guide assumes the disk is named `sda`. Check with `lsblk`.

Create partitions for EFI, boot, and root.

    $ parted -s /dev/sda mklabel gpt
    $ parted -s /dev/sda mkpart primary fat32 1MiB 513MiB
    $ parted -s /dev/sda set 1 boot on
    $ parted -s /dev/sda set 1 esp on
    $ parted -s /dev/sda mkpart primary 513MiB 100%

Format the partitions.

    $ mkfs.vfat -F32 /dev/sda1
    $ cryptsetup -y -v luksFormat /dev/sda2
    $ cryptsetup open /dev/sda2 cryptroot
    $ mkfs -t ext4 /dev/mapper/cryptroot

Mount the partitions.

    $ mount -t ext4 /dev/mapper/cryptroot /mnt
    $ mkdir /mnt/boot
    $ mount /dev/sda1 /mnt/boot

Generate mirror list

    $ pacman -Sy
    $ pacman -S reflector
    $ reflector --verbose --country 'United States' -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist
    $ cp /etc/pacman.d/mirrorlist /mnt

Update and install base system

    $ pacman -Syu --ignore linux
    $ pacstrap -i /mnt base base-devel linux linux-firmware dhcpcd net-tools iw wireless_tools netctl dialog reflector wpa_supplicant vim git grub ansible openssh

Generate and verify fstab.

    $ genfstab -U -p /mnt >> /mnt/etc/fstab
    $ blkid
    $ cat /mnt/etc/fstab

Chroot in and configure the base system

    $ arch-chroot /mnt /bin/bash

    # Install previously fetched mirror list
    $ mv /mirrorlist /etc/pacman.d/mirrorlist

    # Set up locale, uncommenting en_US.UTF-8 UTF-8
    $ vim /etc/locale.gen
    $ locale-gen
    $ echo LANG=en_US.UTF-8 > /etc/locale.conf
    $ export LANG=en_US.UTF-8

    # Time zone
    $ ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

    # Hardware clock
    $ hwclock --systohc --utc

    # Hostname
    $ echo enkoder-laptop > /etc/hostname

    # Set root password
    $ passwd

    # Add encrypt hook to mkinitcpio.conf
    # Edit /etc/mkinitcpio.conf
    #    HOOKS="... encrypt filesystems ..."
    #    Regenerate initramfs
    $ mkinitcpio -p linux

Set up the UEFI bootloader

    $ pacman -S dosfstools efibootmgr
    $ bootctl --path=/boot install

    # Configure bootloader
    $ vim /boot/loader/entries/arch.conf
    #        title       Arch Linux
    #        linux       /vmlinuz-linux
    #        initrd      /initramfs-linux.img
    #        options     cryptdevice=/dev/sda2:cryptroot root=/dev/mapper/cryptroot rw

    $ vi /boot/loader/loader.conf
    #        default     arch
    #        timeout     5

Exit, unmount, and reboot

    $ exit
    $ umount /mnt/boot
    $ umount /mnt
    $ cryptsetup close cryptroot
    $ reboot

Run ansible to bootstrap and enjoy!!

    # log in as root
    $ mkdir -p github.com/enkoder
    $ cd github.com/enkoder
    $ git clone https://github.com/enkoder/dev.git
    $ make
