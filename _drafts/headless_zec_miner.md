connect a single graphics card, plug monitor into GPU via DVI-D
in BIOS:
  * enable UEFI/Legacy boot (rather than just UEFI boot)
  * change boot order to boot from your USB first (not the "UEFI USB" option)
select "auto login" without a password when installing ubuntu

on reboot, change boot order in BIOS to be 1st UEFI SSD

in ubuntu settings in GUI:
* turn off screen lock
* never turn screen off when inactive
* do not require password when waking from suspend
* security and privacy
  * disable error reports

sudo apt-get update
sudo apt-get install openssh-server tmux vim expect #expect is for unbuffer
ifconfig # to get IP address, like 192.168.1.7
# update /etc/hosts with IP

sudo apt-get dist-upgrade

# turn off annoying error reports
sudo systemctl disable apport.service

# set caps lock to be another CTRL key
setxkbmap -option caps:ctrl_modifier
gsettings set org.gnome.settings-daemon.plugins.keyboard active false

# configure tmux, put this in ~/.tmux.conf
unbind C-b
set -g prefix C-s
setw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo ubuntu-drivers devices # to see available drivers
sudo apt-get install nvidia-384 # or whatever is recommended
sudo apt-get --purge remove xserver-xorg-video-nouveau

# enable overclocking
# TODO just do this manually, it works better, see video
sudo nvidia-xconfig --enable-all-gpus
sudo nvidia-xconfig --cool-bits=12
#reboot

# view nvidia card info
nvidia-smi --query-gpu=index,gpu_uuid,display_mode --format=csv

# try to make overclocking automatic
https://unix.stackexchange.com/a/46495
sudo nvidia-settings

# actual mine.sh file, invoked with `sh mine.sh`
export DISPLAY=:0

fan_speed=100
clock_boost=200
mem_boost=800
temp_limit=70 # shut GPUs down if they hit this temp
zec_wallet=t1VaWwfvHhvXTpmHycM7DyEP6ae7mh6KrCD

# for gpu in {0..5}; do echo $gpu; done
cat ./mining-key.txt | sudo -S nvidia-smi -pl 170 && \
cat ./mining-key.txt | sudo -S nvidia-settings \
  -a "[gpu:0]/GPUFanControlState=1" \
  -a "[fan:0]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:0]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:0]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:0]/GpuPowerMizerMode=1" \
  -a "[gpu:1]/GPUFanControlState=1" \
  -a "[fan:1]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:1]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:1]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:1]/GpuPowerMizerMode=1" \
  -a "[gpu:2]/GPUFanControlState=1" \
  -a "[fan:2]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:2]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:2]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:2]/GpuPowerMizerMode=1" \
  -a "[gpu:3]/GPUFanControlState=1" \
  -a "[fan:3]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:3]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:3]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:3]/GpuPowerMizerMode=1" \
  -a "[gpu:4]/GPUFanControlState=1" \
  -a "[fan:4]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:4]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:4]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:4]/GpuPowerMizerMode=1" \
  -a "[gpu:5]/GPUFanControlState=1" \
  -a "[fan:5]/GPUTargetFanSpeed=$fan_speed" \
  -a "[gpu:5]/GPUGraphicsClockOffset[3]=$clock_boost" \
  -a "[gpu:5]/GPUMemoryTransferRateOffset[3]=$mem_boost" \
  -a "[gpu:5]/GpuPowerMizerMode=1" >> ~/mining.log &&

# download https://drive.google.com/drive/folders/0B9EPp8NdigFibDl2MmdXaTFjWDQ
unbuffer ./miner --server us1-zcash.flypool.org --user $zec_wallet.rig1 --pass x --port 3333 --templimit $temp_limit >> ~/mining.log

# to shut it down
sudo shutdown -h now
