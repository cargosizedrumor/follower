# follower.sh - A Simple TShark Wrapper to "Follow TCP/UDP Streams"

Usage: ./follower.sh <tcp|udp|all> <pcap>

Follower is a simple shell script wrapper to tshark that allows you to follow tcp/udp streams as you would in Wireshark's UI.  It runs against your
pcap file and outputs the streams in flat text files for grep options.

My use case for this stemmed from writing Snort/Suricata rules and finding a quicker means of crafting detection content against multiple pcaps. 

I'm certain there are neater ways to do this, but this helps me far more than individually following each stream per pcap in Wireshark.
