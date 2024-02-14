module mkr_vidor #(parameter DELAY = 24000000) (
  output logic d_out = 0,
  input logic clk
);

int unsigned cnt = 0;

always_ff @(posedge clk) begin
  cnt <= cnt + 1;
  if (cnt > DELAY) begin
    cnt <= 0;
    d_out <= ~d_out;
  end
end

endmodule