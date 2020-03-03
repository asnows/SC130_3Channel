-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Wed Oct 31 13:26:43 2018
-- Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top maxtri7x7_shift_ram_0 -prefix
--               maxtri7x7_shift_ram_0_ line_shift_ram_0_stub.vhdl
-- Design      : line_shift_ram_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maxtri7x7_shift_ram_0 is
  Port ( 
    D : in STD_LOGIC_VECTOR ( 12 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 12 downto 0 )
  );

end maxtri7x7_shift_ram_0;

architecture stub of maxtri7x7_shift_ram_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "D[12:0],CLK,CE,Q[12:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_12,Vivado 2018.1";
begin
end;
