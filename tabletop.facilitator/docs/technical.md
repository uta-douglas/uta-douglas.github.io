# Technical Summary

Scenario: The "Split-Brain" Firewall Fracture
Theme: Asymmetric Routing & Identity Failure
 
## Technical Context  
Your Security Layer relies on a geographically distributed cluster of two SRX5600s (ERB and SEIR) connected by redundant Control and Fabric links.
 
## The Incident  
A degradation in the fiber path between ERB and SEIR causes the Control Links to fail intermittently while the Fabric links remain up (or vice versa). This puts the SRX cluster into a “dual-primary” or “split-brain” scenario where both firewalls believe they are the active master for the same Redundancy Groups (Reth interfaces).

## Why this breaks Identity/Cloud  
* Asymmetric Routing: Traffic destined for the Internet (e.g., an SSO request to Azure AD) leaves via the SEIR-SRX (Node 0). The return traffic from the ISP enters via the ERB-MX960 and is handed to the ERB-SRX (Node 1).  
* The Failure: Because the Control Link is degraded, the session table entry created on SEIR-SRX hasn't synced to ERB-SRX. The ERB-SRX drops the return packet as an "invalid state/TCP sequence."  
* Identity Impact: Users can initiate logins, but the "Callback" from the cloud provider (MFA token, SAML assertion) is dropped.  


# Traps

## `tracert` "Trap" for Network Team  
The Success: The trace successfully leaves the local building gateway (10.15.20.1) and hits the internal core.

The Failure: It dies at Hop 4.

The Reality: In a split-brain SRX scenario, the packet actually did go out via the SEIR-SRX. However, when the response came back to the ERB-SRX, the firewall dropped it because it didn't recognize the session. To the user's computer, it looks like the destination is "down," but to the network team, the logs will show the packet exiting the building just fine.

# Technical Responses
## SRX Troubleshooting


| Command | Expected Output (The "Clue") |  
| --------| ---------------------------- |
| `show chassis cluster status` | Redundancy Group 0/1: Both Nodes show as primary. This confirms the "Dual-Primary" state. |
|`show chassis cluster interfaces` | Control Link (em0/fab0): Shows as down or disabled, while Fabric links might show up. |
|`show chassis cluster statistics` | High number of heartbeat timeouts or dropped control packets.|
|`show security flow session` | A session exists for the user on Node 0 (SEIR), but no session exists on Node 1 (ERB). |

## Log entry

If the team looks at the Syslogs or a Packet Capture (PCAP) on the ERB-SRX (Node 1), they should see the following drops:

Log Entry: `RT_FLOW_SESSION_DENY: session rejected 192.168.x.x -> 40.126.32.138 reason: TCP state check failed / No session match`

Explanation: The firewall is receiving the Return packet (SYN-ACK) from Azure/Okta, but since it didn't see the Initial packet (SYN), it drops it as a security violation.


## The "Network Path" Reality

To guide the team if they get stuck, you can "leak" information about the fiber path:

* Physical Layer: A construction crew near the SEIR building is doing utility work. They haven't cut the fiber, but they've bent a conduit, causing high attenuation (dB loss) on the Control Link fibers.

* The Flap: The loss is just bad enough that small heartbeat packets fail, but the higher-power optics for the data fabric are still punching through, keeping the data path "alive" but un-synchronized.

## Resolution Steps (How they "Win")

The team successfully resolves the exercise if they perform these actions in order:

* Isolate the Nodes: Manually force one node into secondary or disabled state to stop the dual-primary conflict (e.g., set chassis cluster redundancy-group 1 node 0 priority 255).

* Force Symmetry: Steer all traffic to one building (ERB or SEIR) by adjusting BGP/OSPF costs so that traffic enters and leaves the same firewall.

* Dispatch Fiber Techs: Identify that the issue is not software/config, but a physical layer degradation between the two data centers.
