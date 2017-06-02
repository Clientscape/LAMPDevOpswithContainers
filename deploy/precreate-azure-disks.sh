#!/bin/bash
qemu-img create -f raw image.raw 16G
mkfs.ext4 ./image.raw
qemu-img convert -f raw -o subformat=fixed,force_size -O vpc image.raw image.vhd
azure-vhd-utils upload --localvhdpath=image.vhd --stgaccountname=xxxx --stgaccountkey=xxxx --containername=vhds --blobname=csmysqlpv.vhd
azure-vhd-utils upload --localvhdpath=image.vhd --stgaccountname=xxxx --stgaccountkey=xxxx --containername=vhds --blobname=csmongopv.vhd
azure-vhd-utils upload --localvhdpath=image.vhd --stgaccountname=xxxx --stgaccountkey=xxxx --containername=vhds --blobname=csmongoconfigpv.vhd
azure-vhd-utils upload --localvhdpath=image.vhd --stgaccountname=xxxx --stgaccountkey=xxxx --containername=vhds --blobname=csredispv.vhd


