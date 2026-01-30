# Technical Summary

## The Incident:
A degradation in the fiber path between ERB and SEIR causes the Control Links to fail intermittently while the Fabric links remain up (or vice versa). This puts the SRX cluster into a “dual-primary” or “split-brain” scenario where both firewalls believe they are the active master for the same Redundancy Groups (Reth interfaces).


## Why this breaks Identity/Cloud:
* Asymmetric Routing: Traffic destined for the Internet (e.g., an SSO request to Azure AD) leaves via the SEIR-SRX (Node 0). The return traffic from the ISP enters via the ERB-MX960 and is handed to the ERB-SRX (Node 1).
* The Failure: Because the Control Link is degraded, the session table entry created on SEIR-SRX hasn't synced to ERB-SRX. The ERB-SRX drops the return packet as an "invalid state/TCP sequence."
* Identity Impact: Users can initiate logins, but the "Callback" from the cloud provider (MFA token, SAML assertion) is dropped.