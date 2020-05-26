FROM fedora:31
RUN dnf -y update && dnf -y install \
      dbus dbus-daemon dbus-glib \
      xorg-x11-server-utils \
      webkit2gtk3 webkit2gtk3-devel \
      mesa-libGL \
      adobe-source-code-pro-fonts abattis-cantarell-fonts \
      gnome-settings-daemon \
      wget tar gtk3 \
      && dnf clean all

ENV LD_LIBRARY_PATH=/opt/gtk/lib
ENV PATH="/opt/gtk/bin:$PATH"

# Configure broadway
ENV BROADWAY_DISPLAY=:5
ENV BROADWAY_PORT=5000
EXPOSE 5000
ENV GDK_BACKEND=broadway

RUN mkdir /projects

RUN for f in "/etc" "/var/run" "/projects" "/root"; do \
    	chgrp -R 0 ${f} && \
    	chmod -R g+rwX ${f}; \
    done

COPY .fonts.conf /root/
COPY .fonts.conf /

#Useful for debug
#RUN dnf -y install gdb gdb-gdbserver java-11-openjdk-devel

COPY ./init.sh /
ENTRYPOINT [ "/init.sh" ]
