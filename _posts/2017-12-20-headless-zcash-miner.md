---
title: "Headless ZCash Mining Rig"
tags: crypto
excerpt: The materials, code, and references I used to build a 6-GPU, headless ZCash (ZEC) mining rig this past spring.
date: "2017-12-20"
---

![mining rig]({{ site.baseurl }}/jekyll_img/zec_miner.jpg)

This past spring I built a computer with 6-GPUs attached to
it to mine cryptocurrencies, i.e. a "mining rig". I intended this computer to be
"headless", or to run without a connected monitor, mouse, or keyboard to save
electricity. I eventually decided that it would be most profitable for me to mine
[ZCash](https://en.wikipedia.org/wiki/Zcash) (a.k.a ZEC), and so this post will
explain how I did that.

You can see my miner working
[here](https://zcash.flypool.org/miners/t1MgGnXQz62fcYDhbRzYVzsA1MmWi8acw22).

### Materials

[Here](https://docs.google.com/spreadsheets/d/1hya5Kh_ydARfzxItFIS3DdyTm_xBnq9FN2kuOLHtOH8/edit?usp=sharing)
is a list of all of the parts I had to buy, along with links to the pages that I bought them from.

Computer:

* [GPU - GTX 1070 8GB, x6](http://www.bestbuy.com/site/nvidia-founders-edition-geforce-gtx-1070-8gb-gddr5-pci-express-3-0-graphics-card/5330700.p?skuId=5330700) - $2,400.00
* [PSU - 1300W Gold Fully Modular](https://www.amazon.com/gp/product/B00COIZTZM/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1) - $240.00
* [MOBO - Intel Z170A](https://www.amazon.com/MSI-Solution-Z170A-Motherboard-SLI/dp/B019EYYNP0/ref=as_li_ss_tl?ie=UTF8&qid=1497041475&sr=8-1&keywords=z170+a+sli+plus&linkCode=sl1&tag=onsimobicom02-20&linkId=2f03fe448094ea1a3c4d02ef3ea2ad61) - $110.00
* [USB/GPU Riser Cables, x6](https://www.amazon.com/gp/offer-listing/B06ZY2R85P/ref=dp_olp_0?ie=UTF8&condition=all&qid=1497835308&sr=8-1) - $65.00
* [CPU - Intel Celeron G3900 dual core 2.80 GHz](https://www.amazon.com/Intel-Celeron-G3900-Dual-core-Processor/dp/B01B2PJRPA/ref=as_li_ss_tl?ie=UTF8&qid=1497408109&sr=8-2&keywords=LGA+1151+skylake+cpu&linkCode=sl1&tag=onsimobicom02-20&linkId=4eae9d4de9a20c90c69af760f9646160) - $55.00
* [DISC - 120 GB SATA3 SSD](https://www.amazon.com/gp/product/B01F9G414U/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1) - $60.00
* [RAM - 4GB Single DDR4 2133 MT/s](https://www.amazon.com/Ballistix-Sport-Single-PC4-19200-288-Pin/dp/B01DPZVP3W/ref=sr_1_1?ie=UTF8&qid=1497984166&sr=8-1&keywords=4+gb+ram+ddr4) - $30.00
* [BOOT - 32GB USB 3.0 Flash Drive](https://www.amazon.com/SanDisk-Ultra-Transfer-Speeds-s-SDCZ48-032G-UAM46/dp/B00KYK2AKO/ref=sr_1_6?ie=UTF8&qid=1497984610&sr=8-6&keywords=usb+3.0) - $16.00
* [DVI to DVI cable (for monitor)](https://www.amazon.com/gp/product/B00IHMFIBY/ref=oh_aui_detailpage_o04_s00?ie=UTF8&psc=1) - $9.00
* [HDMI display emulator](https://www.amazon.com/Headless-Display-Emulator-Headless-1920x1080-generation/dp/B06XT1Z9TF?SubscriptionId=AKIAILSHYYTFIVPWUY6Q) - $8.40
* Monitor (Craigslist) - $10.00
* Mouse (Craiglist) - $5.00
* Keyboard (Craigslist) - $10.00
* Internet access
* Router
* Ethernet cable

Case:

* [1/16" x 1" angled aluminum - 3x 8ft pieces](https://www.lowes.com/pd/Steelworks-8-ft-x-1-2-in-Aluminum-Solid-Angle/3058167) - $16.20
* [3/4" x 3.5 pvc plank - 1x 8ft plank](https://www.lowes.com/pd/Royal-Mouldings-Limited-PVC-Board-Actual-0-75-in-x-3-5-in-x-8-ft/3339716) - $13.48
* [#8x1/2" self tapping sheet metal screws](https://www.lowes.com/pd/Teks-170-Count-8-x-1-in-Zinc-Plated-Self-Tapping-Phillips-Drive-Interior-Exterior-Standard-SAE-Sheet-Metal-Screw/3316508) - $6.50
* [Cabinet plastic protector dots/pads/bumpers](https://www.google.com/search?q=Cabinet+plastic+protector+dots/pad&source=lnms&tbm=shop&sa=X&ved=0ahUKEwiN2_uXk9TUAhUBXT4KHcEvBDwQ_AUICigB&biw=1433&bih=780) - $2.00

Other:

* [Surge protector](https://www.amazon.com/Tripp-Lite-Suppressor-Diagnostic-ULTRABLOK/dp/B0000510R4?th=1) - $23.00
* [Kilowatt meter](https://www.amazon.com/P3-P4400-Electricity-Usage-Monitor/dp/B00009MDBU/ref=sr_1_1?ie=UTF8&qid=1498585402&sr=8-1&keywords=kilowatt+meter) - $19.00
* Box fan (Target) - $17.00
* Smoke detector (Lowes) - $14.00
* 3-prong Extension Cord (Craigslist) - $10.00
* Flame-resistant (plastic/metal) table (Craigstlist) - $25.00

The grand total for everything came to $3,113.70.
I already owned a few things, e.g. a mouse, a smoke detector, PVC boards, which
reduced the costs above.

Aside from the actual rig components, you'll also probably need:

  * a hack-saw to cut the aluminum angles
  * a drill with a screwdriver attachment to assemble the frame
  * sandpaper to remove the rough edges of the aluminum (60 to 120 coarseness)
  * a saw to cut the PVC board (I used a circular saw)

I roughly followed the instructions in [this
video](https://www.youtube.com/watch?v=rPU5jL36maw&t=5140s) to construct the
frame and mount/connect the hardware. It's still probably a good place to start,
though I did have to install an additional support beam because my graphics
cards were too heavy and were bending the frame.

### Setup

Though the rig is going to mine in a "headless" state -- and so won't have a
display, keyboard, or mouse to waste any additional electricity -- you will
still need a monitor, keyboard, and mouse for the initial setup (as seen in the
photo above). Plug those in now.

Unplug any GPUs you have connected to the motherboard.

Turn the power on. To do this, you'll initially need to short the pins on your
motherboard's power switch header with a flat-head screwdriver. (I short pins 6
and 8 on [this picture](https://superuser.com/a/975079). Look in your
motherboard manual to determine which pins you need to connect.) You might need
to hold the screwdriver against the pins for a couple seconds before it turns
on. You'll only need to do this once. From here on, you can just use the on/off
switch on the power supply unit (PSU) to start/stop the computer.

The computer should boot into BIOS because it doesn't have an operating system
installed yet. Once that happens, configure BIOS to automatically boot when it
receives power, then shut the computer down. Download the [latest version of
BIOS](https://www.msi.com/Motherboard/support/Z170A-SLI-PLUS.html) for your
motherboard onto your USB on another computer. Plug in the USB and reboot your
mining rig. Follow the instructions on screen to update your BIOS. Once the
update completes, power down the rig.

Connect a single graphics card to the motherboard via one of your riser cables,
and plug the monitor into the GPU via the DVI-D cable, or an HDMI cable, if
possible. Turn the computer on and it will once again open into BIOS. In BIOS
settings:

  * enable UEFI/Legacy boot (rather than just UEFI boot)
  * change boot order to boot from USB first (not the "UEFI USB" option)

Power off.

On another computer, install Ubuntu 16.04 onto a USB drive. I used [these
instructions](https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-macos#0).

Plug your ubuntu USB drive into a USB port on the rig's motherboard, then turn
the rig back on. The rig should open to the Ubuntu install screen. Follow the
instructions, selecting "auto login" without a password.

Once the install has you reboot, reopen BIOs by hitting F11 (or whatever you are
prompted with) and change the boot order in BIOS to be 1st UEFI SSD. Then
reboot. You can now remove your USB and plug in your remaining GPUs.

Once Ubuntu boots up and you see the desktop, modify the following system
settings:

* turn off screen lock
* never turn screen off when inactive
* do not require password when waking from suspend
* security and privacy
  * disable error reports

Next open a terminal and run the following:

{% highlight bash %}

sudo apt-get update

# add some important services
sudo apt-get install openssh-server tmux vim expect #expect is for unbuffer

# update /etc/hosts on your laptop with IP alias to easily SSH later
ifconfig # to get IP address, like xxx.xxx.x.7

# upgrade existing packages
sudo apt-get dist-upgrade

# turn off annoying error reports
sudo systemctl disable apport.service

# set caps lock to be another CTRL key, optional
setxkbmap -option caps:ctrl_modifier
gsettings set org.gnome.settings-daemon.plugins.keyboard active false

# ensure all of your nvidia cards are detected
nvidia-smi --query-gpu=index,gpu_uuid,display_mode --format=csv

# get graphics card drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo ubuntu-drivers devices # to see available drivers
sudo apt-get install nvidia-384 # install whatever is recommended

{% endhighlight %}

Since this is Ubuntu, we won't have access to the EVGA overclocking program that
most people use on windows. Here's how to get around the limitation:

{% highlight bash %}
sudo nvidia-xconfig
sudo vim /etc/X11/xorg.conf
# change your Device section to include the Coolbits option
Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    Option         "Coolbits" "12"
EndSection

{% endhighlight %}

Save the config file you just edited and reboot.

At this point you're pretty much ready to start mining. You'll probably want to
choose a mining pool to contribute your hashing power to. I like
[flypool](https://zcash.flypool.org/), as it does not charge transaction fees,
consistently earns block rewards, and doesn't require any account setup. Just
point your miner at their servers and start getting paid!

The last step is to download the mining software and start running it.
I used EWBF's ZCash miner for linux, which you can read about
[here](https://bitcointalk.org/index.php?topic=1707546.0) and download
[here](https://drive.google.com/drive/folders/0B9EPp8NdigFibDl2MmdXaTFjWDQ).
Unzip the file to your home directory.

Here's the shell script that I use to run the miner.

{% highlight bash %}
# put this in ~/mine.sh
export DISPLAY=:0 # allow headless mining

fan_speed=100
clock_boost=200
mem_boost=1000
watts_per_gpu=170
mining_pool=us1-zcash.flypool.org # replace with your mining pool URL
temp_limit=70 # shut GPUs down if they hit this temp
zec_wallet=t1MgGnXQz62fcYDhbRzYVzsA1MmWi8acw22 # replace with your wallet address

sudo nvidia-smi -pl $watts_per_gpu && \
sudo nvidia-settings \
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

# keep track of the cards in case one fails
nvidia-smi --query-gpu=index,gpu_uuid,pci.bus_id,display_mode --format=csv >> mining.log

# unbuffer so that you can tail the mining.log file
unbuffer ./miner --server $mining_pool --user $zec_wallet.rig1 --pass x --port 3333 --templimit $temp_limit >> ~/mining.log

{% endhighlight %}

If you've done things correctly, you can now start the miner with:

{% highlight bash %}
  sh mine.sh
{% endhighlight %}

And you should be able to tail the process with:

{% highlight bash %}
  tail -f ~/mining.log
{% endhighlight %}

The log should look something like the following:

{% highlight bash %}

INFO: Detected new work: 3a3ad8bfc081ff22f01a
INFO 20:05:56: GPU3 Accepted share 21ms [A:8600, R:11]
INFO 20:06:05: GPU1 Accepted share 27ms [A:8573, R:15]
INFO 20:06:08: GPU0 Accepted share 24ms [A:8752, R:15]
INFO 20:06:10: GPU1 Accepted share 24ms [A:8574, R:15]
INFO 20:06:15: GPU0 Accepted share 22ms [A:8753, R:15]
INFO 20:06:15: GPU2 Accepted share 28ms [A:8591, R:17]
INFO 20:05:25: GPU4 Accepted share 26ms [A:8797, R:19]
INFO 20:05:26: GPU3 Accepted share 27ms [A:8599, R:11]
Temp: GPU0: 57C GPU1: 56C GPU2: 59C GPU3: 59C GPU4: 58C GPU5: 60C
GPU0: 485 Sol/s GPU1: 484 Sol/s GPU2: 484 Sol/s GPU3: 486 Sol/s GPU4: 489 Sol/s
GPU5: 492 Sol/s
Total speed: 2920 Sol/s

{% endhighlight %}

If it does, congratulations! You're mining.

### Going Headless

At this point, shut the machine off. Unplug the monitor,
keyboard, and mouse, and plug in the HDMI emulator into one of the GPUs. Turn
the mining rig back on.

SSH into the mining rig from another computer using your sudo password
and the IP you found earlier.

Once you have shell access to the mining rig, start a tmux session. I usually
split the pane vertically, running the mining process in one pane and tailing
the mining log in the other. When you are done looking at the log, simply
detatch from tmux and logout from the rig.

Your miner is now headless! You can start, stop, shutdown, and restart the miner
from your laptop over SSH. This is very convenient.

### Other Notes

The miner generates a good bit of heat. For this reason, I keep it in the
coolest place I can (a basement) and have a box fan blowing on it on high at all
times. I also take special precaution to keep it away
from anything that could catch fire, and have installed a smoke detector
directly above it and a thermal motion sensor attached to an alarm pointed at
it 24/7. I haven't had any issues. But I'd rather be safe than sorry!

Two sites that I use to calculate profitability are:

* http://whattomine.com/
* https://www.crypto-coinz.net/crypto-calculator/

I check these roughly once a month to confirm that ZEC is still roughly paying
the best for my hardware.

If I did it all over again, I'd probably opt for higher-end GPUs (1080 TI's) and
simply buy fewer of them. I could have probably achieved comparable hash rates
with three 1080TI's, saved money on a smaller PSU, and cut my electric bill in
half along the way.

The entire setup currently draws approximately 1020W continuously at the wall --
according to my kilowatt meter. My effective cost of electricity is $0.12/kWhr.
So it costs me 12 cents to run the rig each hour, and $2.88 to run per day --
about $88 per month. It's not cheap. But on good months the rig generates
between $500 and $800 in income with zero work required from me. Even factoring
electricity into the equation, the hardware paid for itself within 5 months.

UPDATE:
I've now switched to this miner:
https://bitcointalk.org/index.php?topic=2021765.0
which is under active development

------------

Did this article help you out? Donations welcome:

* ZEC - _t1MgGnXQz62fcYDhbRzYVzsA1MmWi8acw22_
* ETH - _0x8470309D2A9447De1F0f75850D9FA64cE11bA462_
* BTC - _1JEkNAvX8in4mMu94hizTfBkLYEueGedom_
* BCH - _1NiPvxKcmUyMSpt47acQD5H2yeKFJo6wNw_
