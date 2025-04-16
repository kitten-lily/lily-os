# vim: set ft=make :
########################
### bluefin-system.just
########################
## Standardized verbs
# configure- = configure something that is pre-installed on the image
# install-   = install something, no uninstall or configuration provided
# setup-     = install something and also provide configuration and/or uninstallation options
# toggle-    = turn something on/off, logic can be automatic or manual selection
# fix-       = apply fix/patch/workaround for something
# foo        = no verb is used for shortcuts or something deemed important enough to use a super memorable name

[group('Apps')]
install-gaming-flatpaks:
    #!/usr/bin/env bash
    FLATPAKS="lilyos_flatpaks/gaming_flatpaks"
    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/kitten-lily/lily-os-new/main/${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install --or-update ${FLATPAK_LIST}

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak --system -y install --or-update app/com.valvesoftware.Steam/x86_64/stable \
                                            app/com.heroicgameslauncher.hgl/x86_64/stable \
                                            app/net.lutris.Lutris/x86_64/stable \
                                            app/com.vysp3r.ProtonPlus/x86_64/stable \
                                            app/com.dec05eba.gpu_screen_recorder/x86_64/stable \
                                            app/com.github.Matoking.protontricks/x86_64/stable \
                                            runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08 \
                                            runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08 \
                                            runtime/org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/24.08 \
                                            runtime/com.obsproject.Studio.Plugin.OBSVkCapture/x86_64/stable \
                                            runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08 \
                                            runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08 \
                                            runtime/com.valvesoftware.Steam.Utility.steamtinkerlaunch/x86_64/stable

# Install system flatpaks for rebasers
[group('System')]
install-system-flatpaks:
    #!/usr/bin/bash
    FLATPAKS="lilyos_flatpaks/flatpaks"
    FLATPAK_LIST="$(curl https://raw.githubusercontent.com/kitten-lily/lily-os-new/main/${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install --or-update ${FLATPAK_LIST}

# Reset system flatpaks for rebasers
[group('System')]
configure-system-flatpaks:
    #!/usr/bin/bash
    flatpak uninstall --all --delete-data --assumeyes
    ujust install-system-flatpaks

# Configure/Add Fido/Yubi key to an Encrypted disk with key priority
configure-fido2:
    #!/usr/bin/bash
    if [ "$EUID" -ne 0 ]
        then echo "Please run as root"
        exit
    fi
    device=""
    luk=""
    clear; readarray devices <<< $(lsblk -r --fs | grep crypto | awk '{print $1}')
    readarray luks <<< $(lsblk -r --fs | grep luks | awk '{print $1}')
    if [ "${#devices[@]}" -gt 1 ]; then
      while true; do
          echo "select q to quit at anytime"
          for ((i = 0; i < ${#devices[@]}; ++i)); do
               echo $(echo "$i: ${devices[$i]}" | sed -e 's/\\n//g')
          done
          read -p "Select which device you want to work with using the number:  " choice
          clear
          case $choice in
            [Qq]*) exit;;
            ''|*[!0-9]*) echo "invalid selection, please use the numbers or q to quit" ;;
            *) device="${devices[$choice]}"; [[ ! -z $device ]] && break || echo "invalid choice";;
          esac

      done
    else
        device=$(echo "${devices[0]}" | sed -e 's/\\n//g')
        [[ ! "$device"  =~ [:alnum:] ]] && echo "No devices with crypto active ... exiting" && exit
    fi
    if [ "${#luks[@]}" -gt 1 ]; then
      while true; do
          for ((i = 0; i < ${#luks[@]}; ++i)); do
               echo $(echo "$i: ${luks[$i]}" | sed -e 's/\\n//g')
          done
          read -p "Select which volume you want to work with using the number:  " choice
          clear
          case $choice in
            [Qq]*) exit;;
            ''|*[!0-9]*) echo "invalid selection, please use the numbers or q to quit" ;;
            *) luk="${luks[$choice]}"; [[ ! -z $luk ]] && break || echo "invalid choice";;
          esac

      done
    else
        luk=$(echo "${luks[0]}" | sed -e 's/\\n//g')
        [[ ! "$luk"  =~ [:alnum:] ]] && echo "No devices with crypto active ... exiting" && exit
    fi
    [[ $device = */dev/* ]] || device=/dev/$device
    clear;
    echo "Your device is $device  with volume $luk"
    read -p "confirm choices y/n  or quit q " choice
    clear
    case $choice in
      [Qq]*) exit;;
      [Yy]*) : ;;
      *) echo "invalid choice, exiting"; exit;;
    esac

    read -p "do you need to enroll a new key?  if yes insert key before answering  y/n " choice
    case $choice in
        [Yy]* ) systemd-cryptenroll --fido2-device=auto --fido2-with-user-verification=true $device;;
        *) echo "not enrolling a new key" ;;
    esac
    luksline=$(grep -r $luks /etc/crypttab)
    if [[ ! "$luksline" = *"fido2-device"* ]] ; then
        opts=$(echo $luksline | awk '{print $4}')
        newopts=$(echo $luksline | sed "s/$opts/fido2-device=auto,$opts/g")
        sed -i "s/$luksline/$newopts/g" /etc/crypttab
        echo "updated crypttab with fido"
    fi
    dracutfile="/etc/dracut.conf.d/fido2.conf"
    if [ ! -f $dracutfile ]; then
        echo 'add_dracutmodules+=" fido2 "' > $dracutfile
        echo "created fido2 dracut.conf"
    else
        mods="$(grep -r "add_dracutmodules+=" $dracutfile)"
        if [[ $mods = *"dracutmodules+="* ]] ; then
            if [[ ! $mods = *"fido2"* ]] ; then
                sed -i 's/add_dracutmodules+="/add_dracutmodules+=" fido2 /g' "$dracutfile"
            fi
        else
            echo 'add_dracutmodules+=" fido2 "' >> $dracutfile
        fi
        echo "updated fido2 dracut.conf"
    fi
    echo "

    Set the slot priority of the of the password and fido
    0: fido preferred, password ignored  | WARNING !!  This will ONLY allow the fido to unlock
    1: fido preferred, password normal   | This will allow the password to be used if fido isnt present
    "
    read -p ": " choice
    case $choice in
        [0] ) cryptsetup config --key-slot 0 --priority ignore $device ; cryptsetup config --key-slot 1 --priority prefer $device;;
        [1] ) cryptsetup config --key-slot 0 --priority normal $device ; cryptsetup config --key-slot 1 --priority prefer $device;;
        *) echo "invalid option,  leaving slot priorities the same" ;;
    esac
    echo "

    "
    read -p "Enable the initramfs to rebuild ?  y/n " choice
    case $choice in
        [Yy]* ) rpm-ostree initramfs --enable;;
        *) echo "initramfs not rebuilding" ;;
    esac
    echo " Fido Configuration complete "

# Perfrom fido2/u2f and enable authentication with it
configure-u2f-auth:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p $HOME/.config/Yubico
    pamu2fcfg | tee -p $HOME/.config/Yubico/u2f_keys
