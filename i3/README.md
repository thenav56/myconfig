##installed fonts 
>create a folder ~/.fonts and move the *.ttf files there

FontAwesome https://github.com/FortAwesome/Font-Awesome

San Francisco Font https://github.com/supermarin/YosemiteSanFranciscoFont


#Application installed 

- feh 
    - to change wallpapers `sudo apt-get install feh`

- arandr 
    - screen  `sudo apt-get install arandr`

- xprop 
    - to find the class of application 

- lxappearance 
   
   - make font work with gtk `sudo apt-get install lxappearance`
   - open the app lxappearance
   - change the font size , hit apply
   - then open file ~/.gtkrc-2.0 
   - change this line -> gtk-font-name="System San Francisco Display 10"
   - now open file ~/.config/gtk-3.0/setting.ini ; have to change both version
   - change this line -> gtk-font-name=System San Francisco Display 10


- thunar `sudo apt-get install thunar`
    
    - to fix icon theme `sudo apt-get install gnome-icon-theme-full`

- Arc theme
    
    - https://github.com/horst3180/arc-theme#packages -> http://software.....
    - use Arc theme from lxappearance

- Numix icon theme

    - https://github.com/numixproject/numix-icon-theme or http://itsfoss.com/best-icon-themes-ubuntu-1404/
    - set the icon theme from lxappearance

- Rofi 
    - replacment for dmenu
    - `sudo apt-get install rofi`
    - https://davedavenport.github.io/rofi/   
    - add bindsym $mod+d exec rofi -show run ; remove -dmenu bindsym

- Lockscreen script 
    
    - https://github.com/savoca/dotfiles/blob/dark/.bin/scripts/lock.sh



refrences :
    https://github.com/alexbooker/dotfiles
    https://github.com/savoca/dotfiles
    ....
