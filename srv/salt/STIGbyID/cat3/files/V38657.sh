#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38657
# Finding ID:	V-38657
# Version:	RHEL-06-000273
# Finding Level:	Low
#
#     The system must use SMB client signing for connecting to samba 
#     servers using mount.cifs. Packet signing can prevent 
#     man-in-the-middle attacks which modify SMB packets in transit.
#
############################################################

diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38657"
diag_out "  The system must use SMB client"
diag_out "  signing for connecting to samba"
diag_out "  servers using mount.cifs."
diag_out "----------------------------------"
