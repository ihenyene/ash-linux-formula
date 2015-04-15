# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38518
# Finding ID:	V-38518
# Version:	RHEL-06-000133
# Finding Level:	Medium
#
#     All rsyslog-generated log files must be owned by root. The log files 
#     generated by rsyslog contain valuable information regarding system 
#     configuration, user authentication, and other such information. Log 
#     files should be protected from unauthorized access.
#
#  CCI: CCI-001314
#  NIST 800-53 :: SI-11 c
#  NIST 800-53A :: SI-11.1 (iv)
#  NIST 800-53 Revision 4 :: SI-11 b
#
############################################################

{%- set stigId = 'V38518' %}
{%- set helperLoc = 'ash-linux/STIGbyID/cat2/files' %}

script_{{ stigId }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stigId }}.sh
    - cwd: '/root'

{%- set cfgFile = '/etc/rsyslog.conf' %}

# Define list of syslog "facilities":
#    These will be used to look for matching logging-targets
#    within the /etc/rsyslog.conf file
{%- set facilityList = [
    'auth', 
    'authpriv', 
    'cron', 
    'daemon', 
    'kern', 
    'lpr', 
    'mail', 
    'mark', 
    'news', 
    'security', 
    'syslog', 
    'user', 
    'uucp', 
    'local0', 
    'local1', 
    'local2', 
    'local3', 
    'local4', 
    'local5', 
    'local6', 
    'local7',
  ]
%}


# Iterate the facility-list to see if there's any active
# logging-targets defined
{%- for logFacility in facilityList %}
  {%- set srchPat = '^' + logFacility + '\.' %}
  {%- if not salt['cmd.run']('grep -c -E "' + srchPat + '" ' + cfgFile) == '0' %}
    {%- set cfgStruct = salt['file.grep'](cfgFile, srchPat) %}
    {%- set cfgLine = cfgStruct['stdout'] %}
    {%- set logTarg = cfgLine.split() %}
    {%- set logFile = logTarg.pop() %}

# Ensure that logging-target's filename starts with "/"
    {%- if logFile[0] == '/' %}
notify_{{ stigId }}-{{ logFacility }}:
  cmd.run:
    - name: 'echo "Setting owner of {{ logFile }} to root."'

owner_{{ stigId }}-{{ logFacility }}:
  file.managed:
    - name: '{{ logFile }}'
    - user: root
    - replace: false

    {%- else %}
{%- set logFile = logFile[1:] %}
notify_{{ stigId }}-{{ logFacility }}:
  cmd.run:
    - name: 'echo "Setting owner of {{ logFile }} to root."'

owner_{{ stigId }}-{{ logFacility }}:
  file.managed:
    - name: '{{ logFile }}'
    - user: root
    - replace: false

    {%- endif %}
  {%- endif %}
{%- endfor %}
