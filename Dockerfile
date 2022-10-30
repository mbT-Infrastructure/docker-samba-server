FROM madebytimo/base

RUN apt update && apt install -y samba && rm -rf /var/lib/apt/lists/*

RUN mkdir --parents /media/samba

COPY entrypoint.sh /entrypoint.sh

ENV SAMBA_USER=user
ENV SAMBA_PASSWORD=""
ENV SAMBA_WORKGROUP=WORKGROUP

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "smbd", "--foreground", "--log-stdout", "--no-process-group" ]