FROM madebytimo/base

RUN apt update && apt install -y samba && rm -rf /var/lib/apt/lists/*

RUN rm /etc/samba/smb.conf

RUN mkdir --parents /media/samba

COPY entrypoint.sh /entrypoint.sh

ENV SAMBA_USER=user
ENV SAMBA_PASSWORD=""
ENV SAMBA_WORKGROUP=WORKGROUP
ENV ENABLE_PUBLIC_SHARE=false

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "smbd", "--foreground", "--debug-stdout", "--no-process-group" ]
