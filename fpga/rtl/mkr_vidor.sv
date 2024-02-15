module mkr_vidor #(parameter DELAY = 24000000) (
  input  clk,
  input  reset_n,
  input  sam_int_in,
  output sam_int_out,
  
  output        sdram_clk,
  output [11:0] sdram_addr,
  output [1:0]  sdram_ba,
  output        sdram_cas_n,
  output        sdram_cke,
  output        sdram_cs_n,
  inout  [15:0] sdram_dq,
  output [1:0]  sdram_dqm,
  output        sdram_ras_n,
  output        sdram_we_n,

  inout        mkr_aref,
  inout [6:0]  mkr_analog,
  inout [14:0] mkr_gpio
);

logic [24:0] cnt = 0;
logic [3:0] i = 0;
logic [7:0] leds;
assign mkr_gpio[7:0] = leds;

always_ff @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    cnt <= 0;
    leds <= 8'h01;
  end
  else begin
    cnt <= cnt + 1;
    if (cnt > DELAY) begin
      cnt <= 0;
      leds <= leds << 1;

      i <= i + 1;
      if (i > 7) begin
        i <= 0;

        leds <= 8'h01;
      end
    end
  end
end

endmodule