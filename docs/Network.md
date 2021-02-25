# Network and DNS

For our setup we have n+1 IP adresses available (where n = number of nodes).

The additional IP is used for failover.

## DNS

Let's assume you have 3 nodes and 4 IPs 90.100.200.10 to 90.11.200.13. Keep in mind these IP adresses are examples!

Create DNS A records for each of your nodes pointing to its IP and one "general" IP for failover.

| IP | DNS example |
| 90.100.200.10 | kube.example.com |
| 90.100.200.11 | kube1.example.com |
| 90.100.200.12 | kube2.example.com |
| 90.100.200.13 | kube3.example.com |

After the nodes are installed using ansible, one of the nodes will attach the additional IP to itself, thus making itself available at both its node IP and failover IP.
