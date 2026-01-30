# OIT Business Continuity and Information Security Tabletop Exercise


## Scenario: The "Split-Brain" Firewall Fracture
## Theme: Asymmetric Routing & Identity Failure
 
## Technical Context: 
Your Security Layer relies on a geographically distributed cluster of two SRX5600s (ERB and SEIR) connected by redundant Control and Fabric links.
 
## The Incident: 
A degradation in the fiber path between ERB and SEIR causes the Control Links to fail intermittently while the Fabric links remain up (or vice versa). This puts the SRX cluster into a "dual-primary" or "split-brain" scenario where both firewalls believe they are the active master for the same Redundancy Groups (Reth interfaces).

## Why this breaks Identity/Cloud:
* Asymmetric Routing: Traffic destined for the Internet (e.g., an SSO request to Azure AD) leaves via the SEIR-SRX (Node 0). The return traffic from the ISP enters via the ERB-MX960 and is handed to the ERB-SRX (Node 1).
* The Failure: Because the Control Link is degraded, the session table entry created on SEIR-SRX hasn't synced to ERB-SRX. The ERB-SRX drops the return packet as an "invalid state/TCP sequence."
* Identity Impact: Users can initiate logins, but the "Callback" from the cloud provider (MFA token, SAML assertion) is dropped.

## Injects & Flow:
* T0 (Symptoms): Service Desk reports "random" login failures. Some users connect fine (their traffic stayed symmetric), others fail.
* T+30 (Network Discovery): Network team sees the SRX cluster status flapping or "Dual Active" errors in the logs.
* T+45 (Security Twist): Security Ops sees a massive spike in "Deny" logs on the ERB-SRX for legitimate return traffic, initially looking like a DDoS or spoofing attack.

## Root Cause (Malicious Variant): 
An attacker compromised a management account and administratively shut down the specific ports used for the Cluster Control Link (ports FPC1-HA0, etc.), attempting to disrupt logs before exfiltrating data.