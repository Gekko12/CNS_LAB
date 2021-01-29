#a2.tcl
#create 6 nodes and implement the Ping and counts the dropped due to congestion

set ns [new Simulator]
set nf [open out.nam w]
set tf [open out.tr w]

$ns trace-all $tf
$ns namtrace-all $nf

set num 6
for {set i 0} {$i < $num} {incr i} {
    set node($i) [$ns node]
}

$ns duplex-link $node(0) $node(4) 1Mb 10ms DropTail
$ns duplex-link $node(1) $node(4) 1Mb 10ms DropTail
$ns duplex-link $node(2) $node(4) 1Mb 10ms DropTail
$ns duplex-link $node(3) $node(4) 1Mb 10ms DropTail
$ns duplex-link $node(4) $node(5) 1Mb 10ms DropTail

$ns duplex-link-op $node(4) $node(5) queuePos 0.5
$ns queue-limit $node(4) $node(5) 3

$ns color 1 "red"
$ns color 2 "blue"
$ns color 3 "green"
$ns color 4 "yellow"
$ns color 5 "orange"

Agent/Ping instproc recv { from rtt } {
    $self instvar node_
    puts "node [$node_ id] received ping answer from $from with round-trip-time $rtt ms. "
}

set p0 [$ns create-connection Ping $node(0) Ping $node(5) 1 ] 
set p1 [$ns create-connection Ping $node(1) Ping $node(5) 2 ] 
set p2 [$ns create-connection Ping $node(2) Ping $node(5) 3 ] 
set p3 [$ns create-connection Ping $node(3) Ping $node(5) 4 ] 
set p5 [$ns create-connection Ping $node(5) Ping $node(4) 5 ] 

for {set i 0} {$i < 10} {incr i} {
    for {set j 0} {$j < 10} {incr j} {
	$ns at [expr $i + .1 + $j / 10 ]  "$p0 send"
	$ns at [expr $i + .1 + $j / 10 ]  "$p5 send"
	$ns at [expr $i + .2 + $j / 10 ]  "$p1 send"
	$ns at [expr $i + .3 + $j / 10 ]  "$p2 send"
	$ns at [expr $i + .4 + $j / 10 ]  "$p3 send"
	$ns at [expr $i + .5 + $j / 10 ]  "$p5 send"
    }
}

$ns at 10 "finish"

proc finish {} {
    global ns tf nf
    $ns flush-trace
    close $tf
    close $nf
    exec nam out.nam &
    exit 0
}

$ns run


    

