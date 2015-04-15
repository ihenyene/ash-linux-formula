# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38511
# Finding ID:	V-38511
# Version:	RHEL-06-000082
# Finding Level:	Medium
#
#     IP forwarding for IPv4 must not be enabled, unless the system is a 
#     router. IP forwarding permits the kernel to forward packets from one 
#     network interface to another. The ability to forward packets between 
#     two networks is only appropriate for routers.
#
#  CCI: CCI-000366
#  NIST 800-53 :: CM-6 b
#  NIST 800-53A :: CM-6.1 (iv)
#  NIST 800-53 Revision 4 :: CM-6 b
#
############################################################

{%- set stigId = 'V38511' %}
{%- set helperLoc = 'ash-linux/STIGbyID/cat2/files' %}
{%- set chkFile = '/etc/sysctl.conf' %}
{%- set parmName = 'net.ipv4.ip_forward' %}

script_{{ stigId }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stigId }}.sh
    - cwd: '/root'

file_{{ stigId }}-repl:
  file.replace:
    - name: '{{ chkFile }}'
    - pattern: '^{{ parmName }} =.*$'
    - repl: '{{ parmName }} = 0'
