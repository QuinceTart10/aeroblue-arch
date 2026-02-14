FROM ghcr.io/bootcrew/arch-bootc:latest

COPY /system_files /
COPY /build_files /tmp/build

RUN pacman -S --noconfirm plasma-desktop konsole git cmake extra-cmake-modules ninja curl unzip qt6-virtualkeyboard qt6-multimedia qt6-5compat qt6-wayland plasma-wayland-protocols plasma5support kvantum sddm sddm-kcm base-devel && \
    systemctl enable sddm.service

RUN git clone --depth 1 https://gitgud.io/wackyideas/aerothemeplasma.git /tmp/aerothemeplasma && \
    bash /tmp/build/compile.sh && \
    cp -r /tmp/aerothemeplasma/plasma/. /usr/share/plasma && rm -rf /usr/share/plasma/aerothemeplasma-kcmloader /usr/share/plasma/color_scheme /usr/share/plasma/sddm && \
    cp -r /tmp/aerothemeplasma/plasma/sddm/sddm-theme-mod/. /usr/share/sddm/themes/sddm-theme-mod && \
    cp -r /tmp/aerothemeplasma/kwin/. /usr/share/kwin-wayland && rm -rf /usr/share/kwin-wayland/decoration /usr/share/kwin-wayland/effects_cpp /usr/share/kwin-wayland/smod && \
    cp -r /tmp/aerothemeplasma/kwin/smod/. /usr/share/smod && \
    cp -r /tmp/aerothemeplasma/misc/kvantum/Kvantum/. /usr/share/Kvantum && \
    tar -xf /tmp/aerothemeplasma/misc/sounds/sounds.tar.gz --directory /usr/share/sounds && \
    tar -xf /tmp/aerothemeplasma/misc/icons/Windows\ 7\ Aero.tar.gz --directory /usr/share/icons && \
    tar -xf /tmp/aerothemeplasma/misc/cursors/aero-drop.tar.gz --directory /usr/share/icons && \
    cp -r /tmp/aerothemeplasma/misc/mimetype/. /usr/share/mime/packages && \
    cp /tmp/aerothemeplasma/misc/fontconfig/fonts.conf /usr/share/fontconfig/conf.avail/99-aerothemeplasma.conf && \
    echo "QML_DISABLE_DISTANCEFIELD=1" >> /etc/environment && \
    rm -rf /tmp/aerothemeplasma

RUN git clone --depth 1 https://gitgud.io/Gamer95875/Windows-7-Better.git /usr/share/themes/Windows-7-Better

RUN curl https://www.yohng.com/files/TerminalVector.zip -o /tmp/TerminalVector.zip && \
    unzip /tmp/TerminalVector.zip TerminalVector.ttf -d /usr/share/fonts && \
    rm -f /tmp/TerminalVector.zip

RUN rm -rf /tmp/build

# RUN usermod -p "$(echo "changeme" | mkpasswd -s)" root

RUN bootc container lint
