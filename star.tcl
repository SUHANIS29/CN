# Initialize the simulator
set ns [new Simulator]
# Open the trace file
set nf [open star_out.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
# Close the trace file
# Execute nam on the trace file
exec nam star_out.nam &
exit
}
# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
# Create duplex links from central node to other nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail  
$ns duplex-link $n0 $n2 1Mb 10ms DropTail  
$ns duplex-link $n0 $n3 1Mb 10ms DropTail  
$ns duplex-link $n0 $n4 1Mb 10ms DropTail  
# Create and attach TCP agents
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
set tcp3 [new Agent/TCP]  
$ns attach-agent $n0 $tcp3  
set sink3 [new Agent/TCPSink]  
$ns attach-agent $n4 $sink3  
$ns connect $tcp3 $sink3  
# Create FTP applications and attach to TCP agents
set ftp0 [new Application/FTP]  
$ftp0 attach-agent $tcp0  
set ftp1 [new Application/FTP]  
$ftp1 attach-agent $tcp1  
set ftp2 [new Application/FTP]  
$ftp2 attach-agent $tcp2  
set ftp3 [new Application/FTP]  
$ftp3 attach-agent $tcp3  
# Set node colors and labels
$n0 color red  
$n0 label "Center"  
$n1 color yellow  
$n1 label "Node1"  
$n2 color blue  
$n2 label "Node2"  
$n3 color green  
$n3 label "Node3"  
$n4 color orange  
$n4 label "Node4"  
# Schedule events
$ns at 0.5 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"
$ns at 0.5 "$ftp1 start"
$ns at 4.5 "$ftp1 stop"
$ns at 0.5 "$ftp2 start"
$ns at 4.5 "$ftp2 stop"
$ns at 0.5 "$ftp3 start"
$ns at 4.5 "$ftp3 stop"
$ns at 5.0 "finish"
# Run the simulation
$ns run