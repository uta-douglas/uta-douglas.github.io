# Injects & Flow:

## Initial Scenario
[Participant's Page](/tabletop/) link will be given to each of the participants. 

## Timed Injections

### [Injection 1](/tabletop/injection1/) T+0 (Symptoms): 
Service Desk reports "random" login failures. Some users connect fine (their traffic stayed symmetric), others fail.

Conspirators:
* Service Desk Agent

### [Injection 2](/tabletop/injection2/) T+30 (Network Discovery) 
Network team sees the SRX cluster status flapping or "Dual Active" errors in the logs.

Conspirators:
* Network Team Member

### [Injection 3](/tabletop/injection3/) T+45 (Security Twist)
Security Ops sees a massive spike in "Deny" logs on the ERB-SRX for legitimate return traffic, initially looking like a DDoS or spoofing attack.

Conspirators:
* OpSec Team Member