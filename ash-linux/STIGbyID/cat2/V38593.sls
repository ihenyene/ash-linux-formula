# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38593
# Rule ID:              set_system_login_banner
# Finding ID:		V-38593
# Version:		RHEL-06-000073
# SCAP Security ID:	CCE-26974-6
# Finding Level:	Medium
#
#     The Department of Defense (DoD) login banner must be displayed 
#     immediately prior to, or as part of, console login prompts. An 
#     appropriate warning message reinforces policy awareness during the 
#     logon process and facilitates possible legal action against attackers.
#
#  CCI:
#     CCI-001384
#     CCI-001385
#     CCI-001386
#     CCI-001387
#     CCI-001388
#  NIST SP 800-53 :: AC-8 c
#  NIST SP 800-53A :: AC-8.2 (i)
#  NIST SP 800-53 Revision 4:
#     AC-8 c 1
#     AC-8.2 (ii)
#     AC-8 c 2,AC-8.2 (ii)
#     AC-8 c 2,AC-8.2 (ii)
#     AC-8 c 2,AC-8.2 (iii)
#     AC-8 c 3
#
############################################################

script_V38593-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38593.sh
    - cwd: '/root'

file_V38593-etcIssue:
  file.managed:
    - name: '/etc/issue'
    - source: salt://ash-linux/STIGbyID/cat2/files/issue.txt
