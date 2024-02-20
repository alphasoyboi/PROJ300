module mkr_vidor (
  input  clk,
  input  sam_int_in,
  output sam_int_out,
  
  inout        mkr_aref,
  inout [6:0]  mkr_analog,
  inout [14:0] mkr_gpio,
  
	output logic [1:0] command,
	output logic [21:0] data_address,
	output logic [15:0] data_write,
	input  logic [15:0] data_read,
	input  logic data_read_valid,
	input  logic data_write_done
);

localparam int unsigned DELAY = 24000000;
int unsigned counter = 0;

logic [7:0] data = 0;
int unsigned state = 0;

logic [7:0] leds = 0;
assign mkr_gpio[7:0] = leds;

always_ff @(posedge clk) begin
  case (state)
    0: begin
      data_address <= 22'h000000;
      data_write <= {8'h00, data};
      command <= 2'h1;
      if (data_write_done) begin
        state <= 1;
      end
    end
    1: begin
      data_address <= 22'h000000;
      command <= 2'h2;
      if (data_read_valid) begin
        leds <= data_read[7:0];
        data <= data + 1;
        state <= 2;
      end
    end
    2: begin
      if (counter < DELAY) begin
        counter <= counter + 1;
      end else begin
        counter <= 0;
        state <= 0;
      end
    end
  endcase
end

endmodule