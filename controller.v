`timescale 100ms / 100ms

module controller(
  input clk,
  input set_clk,
  input [2:0] src_input,
  input [2:0] dest_input,
  input direction_input, // up = 1, down = 0
  output [2:0] ev_floor
);
  reg [2:0] target_floor_input;
  wire ev_door;

  target_controller u_target_controller(
    // inputs
    .target_floor_input(target_floor_input),
    // outputs
    .ev_floor_output(ev_floor),
    .ev_door_output(ev_door)
  );

  // Inputs
  reg [2:0] src1_input;
  reg [2:0] dest1_input;
  reg direction1_input;

  reg [2:0] src2_input;
  reg [2:0] dest2_input;
  reg direction2_input;

  // Initial State
  reg [1:0] done;
  reg [1:0] on_board = 2'b00;

  initial begin
    done = 2'b11;
    on_board = 2'b00;
  end

  // Assigning Inputs => State Transition
  always @(posedge set_clk)
  begin
    // Assertion
    if (src_input == dest_input)
      $display("Input Assertion Failed");
    else if (src_input > dest_input & direction_input == 1)
      $display("Input Assertion Failed");
    else if (src_input < dest_input & direction_input == 0)
      $display("Input Assertion Failed");
    else begin
      casex (done)
        2'b00: $display("Elevator busy");
        2'bx1: begin
          $display("1 is assigned");
          done = done & 2'b10; // #1 is not done
          src1_input = src_input;
          dest1_input = dest_input;
          direction1_input = direction_input;
        end
        2'b1x: begin
          $display("2 is assigned");
          done = done & 2'b01; // #2 is not done
          src2_input = src_input;
          dest2_input = dest_input;
          direction2_input = direction_input;
        end
      endcase
    end
  end

  // State Transition
  always @(posedge ev_door)
  begin
    if ((done == 2'b10 | done == 2'b00) & (on_board == 2'b10 | on_board == 2'b00) & ev_floor == src1_input) // If 1st rides
    begin
      on_board = on_board + 2'b01; // on_board = 2'bx1;
    end
    else if ((done == 2'b10 | done == 2'b00) & (on_board == 2'b11 | on_board == 2'b01) & ev_floor == dest1_input) // If 1st person arrived dest.
    begin
      done = done + 2'b01; // done = 2'bx1
      on_board = on_board & 2'b10; // on_board = 2'bx0;
    end

    if ((done == 2'b01 | done == 2'b00) & (on_board == 2'b01 | on_board == 2'b00) & ev_floor == src2_input) // If 2nd rides
    begin
      on_board = on_board + 2'b10; // on_board = 2'b1x;
    end
    else if ((done == 2'b01 | done == 2'b00) & (on_board == 2'b10 | on_board == 2'b11) & ev_floor == dest2_input) // If 2nd person arrived dest.
    begin
      done = done + 2'b10; // done = 2'b1x
      on_board = on_board & 2'b01; // on_board = 2'b0x;
    end
  end

  always @(posedge clk)
  begin
    if (done == 2'b10 & on_board == 2'b00) target_floor_input = src1_input;
    else if (done == 2'b10 & on_board == 2'b01) target_floor_input = dest1_input;
    else if (done == 2'b01 & on_board == 2'b00) target_floor_input = src2_input;
    else if (done == 2'b01 & on_board == 2'b10) target_floor_input = dest2_input;
    else if (done == 2'b00 & on_board == 2'b00)
    begin
      if (direction1_input == 1 & direction2_input == 1)
      begin
        if (src1_input < src2_input) target_floor_input = src1_input;
        else if (src1_input > src2_input) target_floor_input = src2_input;
      end
      else if (direction1_input == 0 & direction2_input == 0)
      begin
        if (src1_input > src2_input) target_floor_input = src1_input;
        else if (src1_input < src2_input) target_floor_input = src2_input;
      end
      else target_floor_input = src1_input;
    end
    else if (done == 2'b00 & on_board == 2'b11)
    begin
      if (direction1_input == 1 & direction2_input == 1)
      begin
        if (dest1_input < dest2_input) target_floor_input = dest1_input;
        else if (dest1_input > dest2_input) target_floor_input = dest2_input;
      end
      else if (direction1_input == 0 & direction2_input == 0)
        begin
          if (dest1_input > dest2_input) target_floor_input = dest1_input;
          else if (dest1_input < dest2_input) target_floor_input = dest2_input;
        end
      // Impossible Case
      // else target_floor_input = dest1_input;
    end
    else if (done == 2'b00 & on_board == 2'b01)
    begin
      if (direction1_input == 1 & direction2_input == 1)
      begin
        if (dest1_input < src2_input) target_floor_input = dest1_input;
        else if (dest1_input > src2_input) target_floor_input = src2_input;
      end
      else if (direction1_input == 0 & direction2_input == 0)
      begin
        if (dest1_input > src2_input) target_floor_input = dest1_input;
        else if (dest1_input < src2_input) target_floor_input = src2_input;
      end
      else target_floor_input = dest1_input;
    end
    else if (done == 2'b00 & on_board == 2'b10)
    begin
      if (direction1_input == 1 & direction2_input == 1)
      begin
        if (src1_input < dest2_input) target_floor_input = src1_input;
        else if (src1_input > dest2_input) target_floor_input = dest2_input;
      end
      else if (direction1_input == 0 & direction2_input == 0)
      begin
        if (src1_input > dest2_input) target_floor_input = src1_input;
        else if (src1_input < dest2_input) target_floor_input = dest2_input;
      end
      else target_floor_input = dest2_input;
    end
  end
endmodule

module target_controller(
  input [2:0] target_floor_input,
  output [2:0] ev_floor_output,
  output ev_door_output
);
// Elevator Module
  reg ev_door_open;
  reg [1:0] ev_updown;
  wire ev_door;
  wire [2:0] ev_floor;

  elevator u_elevator(
    // inputs
    .door_open(ev_door_open),
    .updown(ev_updown),
    // outputs
    .door(ev_door),
    .floor(ev_floor)
  );

  reg ev_moving;

  initial begin
    ev_door_open = 0;
    ev_updown = 2'b00;
    ev_moving = 0;
  end

  always @(target_floor_input or ev_floor or negedge ev_door) begin
    if (target_floor_input < ev_floor) begin
      ev_moving = 1;
      ev_door_open = 0; // close door
      #10;
      ev_updown = 2'b10; // down
    end else if (target_floor_input > ev_floor) begin
      ev_moving = 1;
      ev_door_open = 0; // close door
      #10;
      ev_updown = 2'b01; // up
    end else begin
      if (ev_moving == 1) begin
        ev_moving = 0;
        ev_door_open = 1; // open door
        #10;
        ev_updown = 2'b00; // stop
        #20; // Waiting 
        ev_door_open = 0; // close door
      end 
    end
  end

  assign ev_floor_output = ev_floor;
  assign ev_door_output = ev_door;
endmodule
