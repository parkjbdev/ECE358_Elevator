`timescale 100ms / 100ms
module TB_final();
  reg clk;
  reg set_clk;
  reg [2:0] src_input;
  reg [2:0] dest_input;
  reg direction_input;
  wire [2:0] current_floor_output;

  controller u_controller (
    .clk(clk),
    .set_clk(set_clk),
    .src_input(src_input),
    .dest_input(dest_input),
    .direction_input(direction_input),
    .ev_floor(current_floor_output)
  );

  always #1 clk = ~clk;

  initial begin
    clk = 0;
    set_clk = 0;
    #50;

    // 2 to 5
    set_clk = ~set_clk; 
    src_input = 3'b010; dest_input = 3'b101; direction_input = 1'b1; #1 
    set_clk = ~set_clk; 
    #49;

    // 3 to 4
    set_clk = ~set_clk; 
    src_input = 3'b011; dest_input = 3'b100; direction_input = 1'b1; #1 
    set_clk = ~set_clk; 
    #49;

    // Cause Elevator is busy while opening door for the user to get out 
    #30;

    // 4 to 3
    set_clk = ~set_clk; 
    src_input = 3'b100; dest_input = 3'b011; direction_input = 1'b0; #1 
    set_clk = ~set_clk; 

    #1000;
    $finish;
  end

endmodule
