## Injects & Flow:
* T0 (Symptoms): Service Desk reports "random" login failures. Some users connect fine (their traffic stayed symmetric), others fail.
* T+30 (Network Discovery): Network team sees the SRX cluster status flapping or "Dual Active" errors in the logs.
* T+45 (Security Twist): Security Ops sees a massive spike in "Deny" logs on the ERB-SRX for legitimate return traffic, initially looking like a DDoS or spoofing attack.

