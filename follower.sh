#!/bin/bash
# follower.sh - a simple tshark wrapper to "Follow TCP/UDP" streams.

function tcp_stream()
{
    tshark -nr "$file" -T fields -e tcp.stream 2>/dev/null | grep -P "\d*?[^\n]" | sort -nu >> .tcp
    
    grep -v '^ *#' < .tcp | while IFS= read -r t 
    do
        tshark -qnr "$file" -z follow,tcp,ascii,"$t" > "$file"-tcp-session-"$t" && \
	tshark -qnr "$file" -z follow,tcp,hex,"$t" > "$file"-tcp-hex-session-"$t"
    done
    
    rm .tcp
}
function udp_stream()
{
    tshark -qnr "$file" -z conv,udp | grep -P "(\d{1,3}\.){3}\d{1,3}" | awk '{print $1","$3}' >> .udp

    grep -v '^ *#' < .udp | while IFS= read -r u 
    do 
        tshark -qnr "$file" -z follow,udp,ascii,"$u" >> "$file"-udp-sessions && \
        tshark -qnr "$file" -z follow,udp,hex,"$u" >> "$file"-udp-hex-"$u"
    done

    rm .udp
}

case "$1" in
    tcp)
        file=$2
	tcp_stream
	;;
    udp)
	file=$2
        udp_stream
        ;;
    all)
        file=$2
	tcp_stream && udp_stream
	;;
    *)
        echo $"Usage: $0 <tcp|udp|all> <pcap>"
        ;;
esac
