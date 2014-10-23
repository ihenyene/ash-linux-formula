#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38632
# Finding ID:	V-38632
# Version:	RHEL-06-000154
# Finding Level:	Medium
#
#     The operating system must produce audit records containing sufficient 
#     information to establish what type of events occurred. Ensuring the 
#     "auditd" service is active ensures audit records generated by the 
#     kernel can be written to disk, or that appropriate actions will be 
#     taken if other obstacles exist.
#
############################################################

diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38632"
diag_out "  System must produce audit"
diag_out "  records containing sufficient"
diag_out "  information to establish what"
diag_out "  type of events occurred"
diag_out "----------------------------------"
