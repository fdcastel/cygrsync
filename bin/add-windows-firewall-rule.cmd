@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET FIREWALL_RULE_PORT=873
SET FIREWALL_RULE_PROTOCOL=TCP
SET FIREWALL_RULE_NAME=rsync Server Protocol (port 873/TCP)

netsh advfirewall firewall delete rule name=all dir=in protocol=!FIREWALL_RULE_PROTOCOL! localport=!FIREWALL_RULE_PORT! > NUL
IF ERRORLEVEL 1 netsh firewall delete portopening protocol=!FIREWALL_RULE_PROTOCOL! port=!FIREWALL_RULE_PORT! > NUL
netsh advfirewall firewall add rule name="!FIREWALL_RULE_NAME!" dir=in action=allow protocol=!FIREWALL_RULE_PROTOCOL! localport=!FIREWALL_RULE_PORT! > NUL
IF ERRORLEVEL 1 netsh firewall add portopening protocol=!FIREWALL_RULE_PROTOCOL! port=!FIREWALL_RULE_PORT! "!FIREWALL_RULE_NAME!" > NUL
IF ERRORLEVEL 1 ECHO WARNING: Could not setup firewall rule "!FIREWALL_RULE_NAME!"

ENDLOCAL