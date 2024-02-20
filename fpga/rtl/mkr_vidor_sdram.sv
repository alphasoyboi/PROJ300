module vidor_sdram (
  output        sdram_clk,
  output [11:0] sdram_addr,
  output [1:0]  sdram_ba,
  output        sdram_cas_n,
  output        sdram_cke,
  output        sdram_cs_n,
  inout  [15:0] sdram_dq,
  output [1:0]  sdram_dqm,
  output        sdram_ras_n,
  output        sdram_we_n
);

endmodule