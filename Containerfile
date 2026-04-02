FROM ghcr.io/bootcrew/arch-bootc:latest

COPY /system_files /

RUN pacman -S --needed git base-devel && \
    git clone https://aur.archlinux.org/yay.git /tmp/yay && \
    cd /tmp/yay && \
    makepkg -si

RUN yay -S uac-polkit-agent aerothemeplasma-desktop aeroshell-libplasma aeroshell-workspace aeroshell-kwin-components aeroshell-smod aerothemeplasma-sounds aerothemeplasma-icons

RUN git clone --depth 1 https://gitgud.io/Gamer95875/Windows-7-Better.git /usr/share/themes/Windows-7-Better

RUN curl https://www.yohng.com/files/TerminalVector.zip -o /tmp/TerminalVector.zip && \
    unzip /tmp/TerminalVector.zip TerminalVector.ttf -d /usr/share/fonts && \
    rm -f /tmp/TerminalVector.zip

# RUN usermod -p "$(echo "changeme" | mkpasswd -s)" root

RUN bootc container lint
