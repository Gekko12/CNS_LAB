#a4.tcl
#wireless LAN simulation

set ns [new Simulator]
set tf [open out.tr w]
set nf [open out.nam w]

$ns trace-all $tf
$ns namtrace-all-wireless $nf 500 500

set topo [new Topography]
$topo load_flatgrid 500 500

$ns node-config  \
    -adhocRouting DSDV  \
    -llType LL  \
    -macType Mac/802_11  \
    -ifqType Queue/DropTail  \
    -ifqLen 10  \
    -routeTrace ON  \
    -agentTrace ON  \
    -topoInstance $topo  \
    -phyType Phy/WirelessPhy  \
    -propType Propagation/TwoRayGround  \
    -antType Antenna/OmniAntenna  \
    -macTrace ON  \
    -channel [new Channel/WirelessChannel]

$ns color r "red"
$ns color b "blue"

create-god 3
#general operation director

set num 3
for {set i 0} {$i < $num} {incr i} {
    set node($i) [$ns node]
}

$node(0) set X_ 50
$node(0) set Y_ 50
$node(0) set Z_ 0

$node(1) set X_ 100
$node(1) set Y_ 100
$node(1) set Z_ 0

$node(2) set X_ 400
$node(2) set Y_ 400
$node(2) set Z_ 0

set tcp0 [$ns create-connection TCP $node(0) TCPSink $node(1) r]
set tcp1 [$ns create-connection TCP $node(1) TCPSink $node(2) b]

set ftp0 [$tcp0 attach-app FTP]
set ftp1 [$tcp1 attach-app FTP]

$ns at 0 "$node(0) setdest 50 50 100"
$ns at 0 "$node(1) setdest 100 100 100"
$ns at 0 "$node(2) setdest 400 400 100"

$ns at 1 "$ftp0 start"
$ns at 1 "$ftp1 start"

$ns at 10 "$node(1) setdest 300 300 100 "
$ns at 15 "$node(1) setdest 100 100 100"

$ns at 20 "finish"

proc finish {} {
    global nf tf ns
    $ns flush-trace
    close $tf
    close $nf
    exec nam out.nam &
    exit 0
}

$ns run


