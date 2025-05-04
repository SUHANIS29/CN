set ns [new Simulator]

set namfile [open out.nam w]
$ns namtrace-all $namfile

set tracefile [open out.tr w]
$ns trace-all $tracefile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

$ns queue-limit $n0 $n1 50
$ns queue-limit $n1 $n2 50
$ns queue-limit $n2 $n3 50

set tcp0 [new Agent/TCP]
$tcp0 set packetSize_ 500

$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0
$ns connect $tcp0 $sink0

set tcp1 [new Agent/TCP]
$tcp1 set packetSize_ 500

$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$tcp2 set packetSize_ 500

$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp2 $sink2

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$n0 color red
$n0 label "Source"
$n1 color yellow
$n1 label "Receiver1"
$n2 color blue
$n2 label "Receiver2"
$n3 color green
$n3 label "Receiver3"

$ns at 0.5 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"
$ns at 5.0 "$ftp1 start"
$ns at 9.5 "$ftp1 stop"
$ns at 0.5 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"

proc finish {} {
    global ns namfile tracefile
    $ns flush-trace
    close $namfile
    close $tracefile
    exec nam out.nam &
    exit 0
}

$ns at 10.0 "finish"
$ns runonly
