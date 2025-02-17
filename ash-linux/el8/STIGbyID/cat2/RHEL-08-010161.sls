# Ref Doc:    STIG - RHEL 8 v1r9
# Finding ID: V-230238
# Rule ID:    SV-230238r646862_rule
# STIG ID:    RHEL-08-010161
# SRG ID:     SRG-OS-000120-GPOS-00061
#
# Finding Level: medium
#
# Rule Summary:
#       The operating system must prevent system daemons from using
#       Kerberos for authentication
#
# References:
#   CCI:
#     - CCI-000803
#   NIST SP 800-53 :: IA-7
#   NIST SP 800-53A :: IA-7.1
#   NIST SP 800-53 Revision 4 :: IA-7
#
###########################################################################
{%- set stig_id = 'RHEL-08-010161' %}
{%- set helperLoc = 'ash-linux/el8/STIGbyID/cat2/files' %}
{%- set skipIt = salt.pillar.get('ash-linux:lookup:skip-stigs', []) %}
{%- set keytabList = salt.file.find('/etc', maxdepth=1, type='f', name='*.keytab') %}

script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if stig_id in skipIt %}
notify_{{ stig_id }}-skipSet:
  cmd.run:
    - name: 'printf "\nchanged=no comment=''Handler for {{ stig_id }} has been selected for skip.''\n"'
    - stateful: True
    - cwd: /root
{%- else %}
  {%- for keytab in keytabList %}
Delete suspect {{ keytab }} file:
  file.absent:
    - name: '{{ keytab }}'
    - onlyif:
      - '[[ $( rpm --quiet -q krb5-workstation )$? -ne 0 ]]'
      - '[[ $( rpm --quiet -q krb5-server )$? -ne 0 ]]'
  {%- endfor %}
{%- endif %}
