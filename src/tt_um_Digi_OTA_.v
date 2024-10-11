/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_Digi_OTA_ (
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8v power supply
//    input  wire       VAPWR,    // 3.3v power supply
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins, only ua[5:0] can be used
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire Vip, Vin, Out;

assign ua[0] = Vip;
assign ua[1] = Vin;
    
assign ua[2]  = Out;  
//assign uo_out[7:0] = 8'b00000000; 
//assign ui_in[7:0] = 8'b00000000;
//assign ua[5:3]= 3'b000;
 wire INn, INp, INn_CMP, INp_CMP, CMP, EN, not_EN, Op, On, INn_AND, INp_AND; //internals nets 
not IV1(INn, Vip);    
    not INV2(INn_CMP,CMP);
    not IV3(INp, Vin);
    not INV4(INp_CMP,CMP);

    nor NOR1(Op, INn, INn_CMP);
    nor NOR2(On, INp, INp_CMP);
    
    //not IV5(Op, INn_AND);
    //not IV6(On, INp_AND);
    
    xor XOR1(EN, Op, On);
    
    not IV7(not_EN, EN);
    notif1 IT1(CMP, not_EN, Op);  
    
    bufif1 BT1(Out, EN, Op);   
    
//wire Out, Vip, Vin;
  // All output pins must be assigned. If not used, assign to 0.
//assign [0] uo_out  = Out;  // Example: ou_out is the sum of ui_in and uio_in
//assign uo_out[7:1] = 7'b0000000:
    
    
//assign Vip= ui_in [0]   ;
//assign Vin= ui_in [1];

//wire INn, INp, CMP, EN, not_EN, Op, On, Pr, INn_CMP, INp_CMP, INp_NOR, INn_NOR; //internals nets
//not IV1 (INn, Vip);
//not IV2 (INn, CMP);
//not IV3 (INp, Vin);
//not IV4 (INp, CMP);

    
//nor NOR1 (INn_NOR, INn, INn_CMP):
//nor NOR2 (INp_NOR, INp, Inp_CMP);
    
//not IV5 (Op, INn_CMP);
//not IV6 (On, INp_CMP);
    
//not IV7 (not_EN, EN);
//xor XOR1 (EN, Op, On);
//bufif1 BT1 (Pr, EN, Op);
//notif1 IT1 (CMP, not_EN, Op);
   
  assign uio_out = 0;
    assign uio_oe  = 0;
    
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};
    
endmodule
