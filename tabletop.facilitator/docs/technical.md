# Technical Summary

Scenario: The "Split-Brain" Firewall Fracture
Theme: Asymmetric Routing & Identity Failure
 
## Technical Context: 
Your Security Layer relies on a geographically distributed cluster of two SRX5600s (ERB and SEIR) connected by redundant Control and Fabric links.
 

## The Incident:
A degradation in the fiber path between ERB and SEIR causes the Control Links to fail intermittently while the Fabric links remain up (or vice versa). This puts the SRX cluster into a “dual-primary” or “split-brain” scenario where both firewalls believe they are the active master for the same Redundancy Groups (Reth interfaces).


## Why this breaks Identity/Cloud:
* Asymmetric Routing: Traffic destined for the Internet (e.g., an SSO request to Azure AD) leaves via the SEIR-SRX (Node 0). The return traffic from the ISP enters via the ERB-MX960 and is handed to the ERB-SRX (Node 1).
* The Failure: Because the Control Link is degraded, the session table entry created on SEIR-SRX hasn't synced to ERB-SRX. The ERB-SRX drops the return packet as an "invalid state/TCP sequence."
* Identity Impact: Users can initiate logins, but the "Callback" from the cloud provider (MFA token, SAML assertion) is dropped.


# Traps

## `tracert` "Trap" for Network Team:
The Success: The trace successfully leaves the local building gateway (10.15.20.1) and hits the internal core.

The Failure: It dies at Hop 4.

The Reality: In a split-brain SRX scenario, the packet actually did go out via the SEIR-SRX. However, when the response came back to the ERB-SRX, the firewall dropped it because it didn't recognize the session. To the user's computer, it looks like the destination is "down," but to the network team, the logs will show the packet exiting the building just fine.