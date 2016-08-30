# Finding ID:	RHEL-07-040580
# Version:	RHEL-07-040580_rule
# SRG ID:	SRG-OS-000480-GPOS-00227
# Finding Level:	high
# 
# Rule Summary:
#	SNMP community strings must be changed from the default.
#
# CCI-000366 
#    NIST SP 800-53 :: CM-6 b 
#    NIST SP 800-53A :: CM-6.1 (iv) 
#    NIST SP 800-53 Revision 4 :: CM-6 b 
#
#################################################################
{%- set stig_id = 'RHEL-07-040580' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat1/files' %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if salt['pkg.version']('net-snmp') %}
{%- else %}
cmd_{{ stig_id }}-missing:
  cmd.run:
    - name: 'echo "No SNMP agent installed"'
    - cwd: /root
{%- endif %}
