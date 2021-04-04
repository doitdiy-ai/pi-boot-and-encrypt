# pi-boot-and-encrypt

#### Prepare a Raspberry Pi OS SD card before first boot on a Windows PC.

This is a 100% script-based way to prepare an SD card that has a freshly installed Raspberry Pi image to run headless. It'll enable WiFi, SSH, VNC, hostname(s), filesystem encryption, etc.
It only uses the FAT32 */boot* partition on the SD card or the .img file. You don't need to change anything about the ext4 (Linux) partition. And, it is done with just PowerShell.

##### How to use it

It only needs the *boot-config.ps1* file. You'll need a freshly imaged SD card with Raspberry Pi OS (use Raspberry Pi imager from raspberrypi.org), and make sure it is inserted in the card reader connected to a PC. After downloading script, right-click and select 'Run with Powershell'. If you get a request for confirmation, select Yes (it's always recommended to check out any scripts before running them).

In the window that pops up, do the following:
- Select the drive that has the SD Cards
- Enter a new password for the pi user (up to you, later on in the boot process, you'll be forced to change it)
- Enter a password to log on during the initial boot process to initially encrypt the main file system and later to unlock that encrypted file systemd
- Enter the WiFi ssid that you'll want the Raspberry Pi to connect to
- Enter the WiFi passcode
- Enter the hostname you want to use for the raspberry pi (example: raspi8gb)
- Enter the hostname you want to use for during unlocking of the encrypted filesystem (example: raspi8gb.crypt)

After that, hit the *Configure* button. Then eject the SD card, pop it in your Raspberry Pi and turn it on. While not necessary, it'll be helpful at this point to have a screen connected to the Raspberry Pi, so you can see what is going on.

##### The four boots

- First boot:
  - __No action needs to be taken__, the activities below all happen in the background.
  - Enable SSH, VNC, copy public keys to the sd card, set the hostname, enable camera, set screen do_resolution
  - Set the timezone (to Central...), locale, keyboard layout
  - Set the pi password (note, no plaintext password here. Password is included as a md5crypt hash), set the password to expired (so at first login, the user has to enter a new password) and lock the user account (it'll be unlocked later on)
  - Move some bash scripts to the ext4 main file system and set up the first bash script to run after the first reboot
  - Reboot
- Second boot
  - __Still no actions need to be taken__, the below activities also happen in the background, but they will take some time (about 5 minutes), so __be patient__.
  - __The pi user still cannot log on during this boot sequence__.
  - The pre_encrypt shell script runs during this phase.
  - It's main task is to set up initramfs and dropbear
  - Initramfs is a small file system that will run at boot up. Once the main file system is encrypted, initramfs is needed to be able to unlock the main file system before you can boot into that.
  - Dropbear is a small SSH server that needs to be added to initramfs, so you can connect to it using SSH (keeping everything headless)
  - The creation of initramfs takes about 4 minutes, hence the long wait.
  - After it completes, the Raspberry Pi will reboot again.
- Third boot
  - Now, the Raspberry Pi will boot into initramfs, where we'll prepare the main filesystem for encryption
  - Give it a few minutes for this boot to complete and the Raspberry Pi to connect to your WiFi network
  - Connect to it using SSH and using the encrypt hostname (raspi8gbcrypt in my example above). On the Windows PC, in a cmd window enter:

    >ssh root<span>@</span>raspi8gbcrypt.lan -p 23
  - The initramfs SSH port is set to 23 (which officially is the telnet port..). This is done to keep the server signature checks that are done by the windows SSH clients separate when logging in to either initramfs vs. the main filesystem
  - After running the SSH command above, you'll be:
    - Logged in right away (meaning your SSH keys were not passphrase protected, which is not advisable)
    - You'll be asked for a passphrase (which is the passphrase of your SSH key). If you don't know this passphrase, just hit Enter, and it'll ask for your password next
    - It'll ask for the password. This would be the password you entered in the powershell window in the 'Decrypt password' field
  - Now that you're logged in, type:

    > encrypt
  - It'll start up the encrypt.sh script, which does the steps needed to encrypt the main file system.
  - Some steps are time-consuming. In particular creating a backup of the file system before encryption, and then copying that backup into the encrypted file system, will take about 5 minutes each.
  - After filesystem checks, reduction of the filesystem and the creation of a backup, the script will ask you for confirmation to created the encrypted filesystem and then you'll need to enter a passphrase. __Make it a strong passphrase and remember it!__ This passphrase provides protection against decryption of the main file system.
  - After the main file system is encrypted, you'll have to enter that passphrase to unlock it. After that, the backup of the main file system is copied back into the main file system. Again, this'll take about 4 - 5 minutes.
  - Then, system will reboot into the main file system
- Fourth boot
  - This is the final boot. The post_encrypt shell script will run here. It's main activity is to update the initramfs with the changes made after the third boot.
  - __The pi user is still locked__, as this step needs to complete first (or.. at least, it can't be interrupted by a user doing a reboot while the update is still running).
  - After the initramfs update completes, the pi user will be unlocked. Connect with SSH, this time using the hostname entered in the 'Hostname' field in the powershell script. In the example case that would be:

    > ssh pi<span>@</span>raspi8gb.lan
  - As above one of three things can happen:
     - Logged in right away (meaning your SSH keys were not passphrase protected, which is definitely not advisable)
     - You'll be asked for a passphrase (which is the passphrase of your SSH key). If you don't know this passphrase, just hit Enter, and it'll ask for your password next
     - It'll ask for the password. This would be the password you entered in the powershell window in the 'Pi Password' field
  - After either of these, you'll be prompted to change the password of the pi user

This completes the full setup, including the encryption of the main file system.

#### Normal Usage
The above is all a one-time setup. In normal usage, when the Raspberry Pi is rebooted, the process to get it fully running is as follows:
- Start the Raspberry Pi
- Wait a while to give it time to connect to the WiFi Network
- Connect via ssh to the Raspberry Pi:

  > ssh root<span>@</span>raspi8gbcrypt.lan -p 23
- After you're logged in, type:

  > cryptroot-unlock
- It'll ask for the unlock passphrase that you originally entered during the third boot phase. After that, it'll unlock the main file system and reboot.
- When the reboot completes, you can SSH in:

  > ssh pi<span>@</span>raspi8gb.lan

Or, you can VNC into the Raspberry Pi.

One note about hostnames: in my WiFi network, I need to add .lan when doing SSH or VNC to the hostnames I entered in the powershell script. This may be different in different set ups. It could be .local instead of .lan, or... you may have to find out the IP address (easiest way to do that is to use the Fing app on a phone that is connected to the same WiFi network).

That should be about it!
