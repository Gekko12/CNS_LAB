#a1.tcl
#creates three node network and measure packet drop

set ns [new Simulator]
set nf [open out.nam w]
set tf [open out.tr w]

$ns trace-all $tf
$ns namtrace-all $nf

set num 3
for {set i 0} {$i < $num} {incr i} {set node($i) [ $ns node] }

$ns duplex-link $node(0) $node(1) 1Mb 10ms DropTail
$ns duplex-link $node(1) $node(2) 400Kb 10ms DropTail

$ns duplex-link-op $node(1) $node(2) queuePos 0.5
$ns queue-limit $node(1) $node(2) 10

$node(0) label "UDP"
$node(2) label "NULL"

$ns color r "yellow"

set udp [ $ns create-connection UDP $node(0) Null $node(2) r]
set cbr [ $udp attach-app Traffic/CBR]

$cbr set packetSize_ 960
$cbr set interval_ 0.01
$cbr set rate_ 1Mb

$ns at 0.0 "$cbr start"
$ns at 10 "finish"

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam out.nam &
    exit 0
}

$ns run


