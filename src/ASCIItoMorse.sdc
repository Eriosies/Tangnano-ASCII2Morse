//Copyright (C)2014-2021 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8 
//Created Time: 2021-10-24 19:16:17
create_clock -name CLK -period 41.667 -waveform {0 20.834} [get_ports {clk}]
