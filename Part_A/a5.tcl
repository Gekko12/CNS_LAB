#a5.tcl
#GSM simulation

set ns [new Simulator]
set tf [open out.tr w]
set nf [open out.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

set node(msc) [$ns node]
set node(bs1) [$ns node]
set node(bs2) [$ns node]
set node(ms1) [$ns node]
set node(ms2) [$ns node]

$node(msc) label "MSC"
$node(bs1) label "BS1"
$node(bs2) label "BS2"
$node(ms1) label "MS1"
$node(ms2) label "MS2"

$ns duplex-link $node(msc) $node(bs1) 1Mb 10ms DropTail
$ns duplex-link $node(msc) $node(bs2) 1Mb 10ms DropTail
$ns duplex-link $node(bs1) $node(ms1) 1Mb 1ms DropTail
$ns duplex-link $node(bs2) $node(ms2) 1Mb 1ms DropTail

$ns bandwidth $node(bs1) $node(ms1) 9.6Kb simplex
$ns bandwidth $node(ms1) $node(bs1) 9.6Kb simplex

$ns insert-delayer $node(bs1) $node(ms1) [new Delayer]

set tcp [$ns create-connection TCP $node(ms1) TCPSink $node(ms2) 0]

set ftp [$tcp attach-app FTP]

$ns at 0.1 "$ftp start"
$ns at 20 "finish"

proc finish {} {
    global ns tf nf
    $ns flush-trace
    close $tf
    close $nf
    exec nam out.nam &
    exit 0
}

$ns run



