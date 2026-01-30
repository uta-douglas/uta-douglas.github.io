# Injects & Flow:

## Initial Scenario
[Participant's Page](/tabletop/) link will be given to each of the participants. 

## Timed Injections

### [Injection 1](/tabletop/injection1/) T+0 (Symptoms): 
Service Desk reports "random" login failures. Some users connect fine (their traffic stayed symmetric), others fail.

Conspirators:  
* Service Desk - Steph D'Adamo

### [Injection 2](/tabletop/injection2/) T+30 (Network Discovery) 
Network team sees the SRX cluster status flapping or "Dual Active" errors in the logs.

Conspirators:  
* Network Team - Lenny Cruz

### [Injection 3](/tabletop/injection3/) T+45 (Security Twist)
Security Ops sees a massive spike in "Deny" logs on the ERB-SRX for legitimate return traffic, initially looking like a DDoS or spoofing attack.

Conspirators:  
* OpSec Team Member


## Responses

If network team asks for "more logs," you can tell them that Dr. Thorne is technically savvy and has already provided a tracert that looks normal (because ICMP might follow a different path or succeed where TCP state fails), which usually serves as a great "red herring" to see if they rely too much on basic pings!
[Dr. Thorne's tracert](/tabletop/INC-88421-tracert)