#a3.tcl
#Implementing ethernet LAN
#this is a gappy language leave gap after every word


set ns [new Simulator]
set tf [open out.tr w]
set nf [open out.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

set node(0) [$ns node]

set num 6
for {set i 1} {$i <= $num} {incr i} {
    set node($i) [$ns node]
    lappend nodelist $node($i)
}

$ns make-lan $nodelist 10Mb 10ms LL Queue/DropTail Mac/802_3 Channel

$ns duplex-link $node(0) $node(1) 1mb 10ms DropTail
$ns duplex-link-op $node(0) $node(1) queuePos 0.5
$ns duplex-link-op $node(0) $node(1) orient right

$ns color b "blue"

set tcp0 [$ns create-connection TCP $node(0) TCPSink $node(5) b]
set tcp1 [$ns create-connection TCP $node(2) TCPSink $node(6) b]

set ftp0 [$tcp0 attach-app FTP]
set ftp1 [$tcp1 attach-app FTP]

set err [new ErrorModel]
$err set rate 0.001
$ns lossmodel $err $node(0) $node(1)

$tcp0 attach $tf
$tcp0 trace cwnd_

$tcp1 attach $tf
$tcp1 trace cwnd_

$ns at 0.1 "$ftp0 start"
$ns at 0.2 "$ftp1 start"

$ns at 10 "finish"

proc finish {} {
    global tf nf ns
    $ns flush-trace
    close $tf
    close $nf
    exec nam out.nam &
    exit 0
}

$ns run



