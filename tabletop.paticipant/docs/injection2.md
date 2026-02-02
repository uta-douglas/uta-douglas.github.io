# Injection #2

*Time: 2026-02-13 1:30 PM (15 minutes into the exercise)*

## Network Discovery - Initial Findings

**Observation:** The network team reports seeing the SRX cluster status flapping, accompanied by "Dual Active" errors in the firewall logs.

**Technical Detail:** This indicates a "Split-Brain" Firewall Fracture. A degradation in the fiber path between the two SRX5600 firewalls (ERB and SEIR) is causing the Control Links (em0/fab0 interface) to fail intermittently. As a result, both firewalls are now operating in a dual-primary state, each believing it is the active master.

## Immediate Impacts Reported:

*   **Identity Failure:** Users can initiate login processes (e.g., to Azure AD), but the crucial callback from the cloud provider (containing MFA tokens, SAML assertions, etc.) is being dropped before it reaches the user, preventing successful authentication.
*   **Asymmetric Routing / Session Drops:** Traffic initiated by users leaves the network via one SRX (e.g., SEIR-SRX), but the return traffic attempts to enter via the other (e.g., ERB-SRX). Due to the control link failure, the session table is not being synchronized between the two firewalls. The ERB-SRX, not having seen the initial connection, drops the return packet with an "invalid state/TCP sequence" error.
*   **Misleading `tracert` Output:** Preliminary `tracert` attempts might show successful outbound connectivity from the local building, but then mysteriously "die" at an internal hop. This is deceiving, as the outbound packet did leave, but its return was dropped by the other firewall.

## Key Troubleshooting Clues (for the Network Team):

*   Running `show chassis cluster status` on either SRX would likely reveal both nodes reporting as `primary` for Redundancy Group 0 and 1.
*   `show chassis cluster interfaces` would probably show the Control Link (em0/fab0) as `down` or `disabled`.
*   Syslogs or Packet Captures (PCAP) on the ERB-SRX (the firewall dropping return traffic) would contain `RT_FLOW_SESSION_DENY` entries, specifically stating `session rejected ... reason: TCP state check failed / No session match`. This confirms the firewall is receiving return packets for sessions it didn't initiate.
