# Samba-server image

This Docker image contains a simple samba server.

It provides a public share accessable by the guest user and a restricted share only accessable with authentication.

## Environment variables

- `SAMBA_USER`
    - Username for authentication. For example `SAMBA_USER=user`
- `SAMBA_PASSWORD`
    - Password for authentication. For example `Username for authentication=placepasswordhere`
- `SAMBA_WORKGROUP`
    - The workgroup of the samba server. For example `SAMBA_WORKGROUP=WORKGROUP`

## Volumes

To persist container data you can define some volumes. Directories that contain data are

- `/media/samba`
    - Contains all data of the samba server
- `/media/samba/public`
    - Contains the data of the public share
- `/media/samba/restricted`
    - Contains the data of the restricted share


## Development

To build the image locally run:
```bash
./docker-build.sh
```