set ns [new Simulator]

set nf [open out.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns color 10 red
$ns color 11 green
$ns color 30 yellow
$ns color 31 blue

$ns simplex-link $n0 $n1 1Mb 10ms DropTail
$ns simplex-link $n1 $n2 1Mb 10ms DropTail
$ns simplex-link $n2 $n3 1Mb 10ms DropTail
$ns simplex-link $n3 $n0 1Mb 10ms DropTail

# TCP Agents
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0
$ns connect $tcp0 $sink0

set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp2 $sink2

# FTP Applications
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

# Flow ID and Node Properties
$tcp0 set fid_ 30
$n0 color red
$n0 label "Source"

$tcp1 set fid_ 31
$n1 color yellow
$n1 label "Receiver1"

$tcp2 set fid_ 11
$n2 color blue
$n2 label "Receiver2"

$n3 label "Receiver3"
$n3 color green

# Simulation Events
$ns at 0.5 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"

$ns at 0.5 "$ftp1 start"
$ns at 4.5 "$ftp1 stop"

$ns at 0.5 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"

$ns at 5.0 "finish"

# Finish Procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

$ns run