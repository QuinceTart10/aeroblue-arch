FROM ghcr.io/bootcrew/arch-bootc:latest

RUN pacman -S --noconfirm plasma-desktop konsole sddm
RUN systemctl enable sddm.service

# RUN usermod -p "$(echo "changeme" | mkpasswd -s)" root

RUN bootc container lint
