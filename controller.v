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

  // Variables
  reg [1:0] done;
  reg [1:0] on_board = 2'b00;

  initial begin
    done = 2'b11;
    on_board = 2'b00;
  end

  // Assigning Inputs
  always @(posedge set_clk) begin
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

  always @(posedge ev_door) begin
    // On Destination Arrival
    // 1st person
    // done: 2'bx0, on_board: 2'bx0
    if ((done == 2'b10 | done == 2'b00) & (on_board == 2'b10 | on_board == 2'b00) & ev_floor == src1_input) // If 1st rides
    begin
      on_board = on_board + 2'b01; // on_board = 2'bx1;
    end
    // done: 2'bx0, on_board: 2'bx1
    else if ((done == 2'b10 | done == 2'b00) & (on_board == 2'b11 | on_board == 2'b01) & ev_floor == dest1_input) // If 1st person arrived dest.
    begin
      done = done + 2'b01; // done = 2'bx1
      on_board = on_board & 2'b10; // on_board = 2'bx0;
    end

    // 2nd person
    // done: 2'b0x, on_board: 2'b0x
    if ((done == 2'b01 | done == 2'b00) & (on_board == 2'b01 | on_board == 2'b00) & ev_floor == src2_input) // If 2nd rides
    begin
      on_board = on_board + 2'b10; // on_board = 2'b1x;
    end
    // done: 2'b0x, on_board: 2'b1x
    else if ((done == 2'b01 | done == 2'b00) & (on_board == 2'b10 | on_board == 2'b11) & ev_floor == dest2_input) // If 2nd person arrived dest.
    begin
      done = done + 2'b10; // done = 2'b1x
      on_board = on_board & 2'b01; // on_board = 2'b0x;
    end
  end

  always @(posedge clk) begin
    if (done == 2'b00)
    begin
      if (direction1_input == 1 & direction2_input == 1)
      begin
        if (on_board == 2'b01) // only 1 is on ride
        begin
          // if (src2_input < ev_floor) begin end // ignore
          // else if (src2_input == ev_floor) begin end // open and close door. will be done naturally
          // else 
          if (src2_input > ev_floor)
          begin
            // TASK: goto [src2, dest1] in ascending order
            // maybe only min? (because it's going up)
            if (src2_input < dest1_input) target_floor_input = src2_input;
            else if (src2_input > dest1_input) target_floor_input = dest1_input;
          end
        end
  
        else if (on_board == 2'b10) // only 2 is on ride
        begin
          // if (src1_input < ev_floor) begin end // ignore
          // else if (src1_input == ev_floor) begin end // open and close door. will be done naturally
          // else 
          if (src1_input > ev_floor)
          begin
            // TASK: goto [src1, dest2] in ascending order
            // maybe only min? (because it's going up)
            if (src1_input < dest2_input) target_floor_input = src1_input;
            else if (src1_input > dest2_input) target_floor_input = dest2_input;
          end
        end
  
        else if (on_board == 2'b00) // 1 and 2 both is not on ride yet
        begin
          // TASK: goto [src1, src2] in ascending order
          // maybe only min? (because it's going up)
          if (src1_input < src2_input) target_floor_input = src1_input;
          else if (src1_input > src2_input) target_floor_input = src2_input;
        end
  
        else if (on_board == 2'b11) // 1 and 2 is both on ride
        begin
          // TASK: goto [dest1, dest2] in ascending order
          // maybe only min? (because one will be done)
          if (dest1_input < dest2_input) target_floor_input = dest1_input;
          else if (dest1_input > dest2_input) target_floor_input = dest2_input;
        end
      end
      else if (direction1_input == 0 & direction2_input == 0)
      begin
        if (on_board == 2'b01) // only 1 is on ride
        begin
          // if (src2_input > ev_floor) begin end // ignore
          // else if (src2_input == ev_floor) begin end // open and close door. will be done naturally
          // else 
          if (src2_input < ev_floor)
          begin
            // TASK: goto [src2, dest1] in descending order
            // maybe only max? (because it's going down)
            if (src2_input > dest1_input) target_floor_input = src2_input;
            else if (src2_input < dest1_input) target_floor_input = dest1_input;
          end
        end
  
        else if (on_board == 2'b10) // only 2 is on ride
        begin
          // if (src1_input > ev_floor) begin end // ignore
          // else if (src1_input == ev_floor) begin end // open and close door. will be done naturally
          // else
          if (src1_input < ev_floor)
          begin
            // TASK: goto [src1, dest2] in descending order
            // maybe only max? (because it's going down)
            if (src1_input > dest2_input) target_floor_input = src1_input;
            else if (src1_input < dest2_input) target_floor_input = dest2_input;
          end
        end
  
        else if (on_board == 2'b00) // 1 and 2 both is not on ride yet
        begin
          // TASK: goto [src1, src2] in descending order
          // maybe only max? (because it's going down)
          if (src1_input > src2_input) target_floor_input = src1_input;
          else if (src1_input < src2_input) target_floor_input = src2_input;
        end
  
        else if (on_board == 2'b11) // 1 and 2 is both on ride
        begin
          // TASK: goto [dest1, dest2] in descending order
          // maybe only max? (because one will be done)
          if (dest1_input > dest2_input) target_floor_input = dest1_input;
          else if (dest1_input < dest2_input) target_floor_input = dest2_input;
        end
      end
  
      // if 1 and 2 is not going the same way
      // get 1 first, get 2 next.
      else
      begin
        // TASK: goto [src1, dest1, src2, dest2] in order
        // src1 first.. when src1 arrives, done flag will be set which leads
        // to differenct state.
        //
        // if nobody is riding, src1 first.
        if (on_board == 2'b00) target_floor_input = src1_input;
        else if (on_board == 2'b01) target_floor_input = dest1_input;
        // if nobody is riding
        // since src1 will be arrived, done flag will be set and 2 will be
        // handled there.
        // else if (on_board == 2'b00) target_floor_input = src2_input;
        // else if (on_board == 2'b10) target_floor_input = dest2_input;
      end
    end
    // PSEUDO Code for above
    // if 1 and 2 is both going up
    //  if only 1 is on ride (01)
    //    if src2 < ev ignore
    //    elif src2 == ev open
    //    elif src2 > ev
    //      goto min(src2,dest1) and open
    //      goto max(src2,dest1) and open
    //  if only 2 is on ride (10)
    //    if src1 < ev: ignore
    //    elif src1 === ev: open
    //    elif src1 > ev
    //      goto min(src1, dest2) and open
    //      goto max(src1, dest2) and open
    //  if 1 and 2 both is not on ride yet (00)
    //    goto min(src1, src2) and open
    //    goto max(src1, src2) and open
    //  if 1 and 2 is both on ride (11)
    //    goto min(dest1, dest2) and open
    //    goto max(dest1, dest2) and open
    // if 1 and 2 is both going down
    //  if only 1 is on ride (01)
    //    if src2 > ev ignore
    //    elif src2 == ev open
    //    elif src2 < ev
    //      goto max(src2,dest1) and open
    //      goto min(src2,dest1) and open
    //  if only 2 is on ride (10)
    //    if src1 > ev: ignore
    //    elif src1 === ev: open
    //    elif src1 < ev
    //      goto max(src1, dest2) and open
    //      goto min(src1, dest2) and open
    //  if 1 and 2 both is not on ride yet (00)
    //    goto max(src1, src2) and open
    //    goto min(src1, src2) and open
    //  if 1 and 2 is both on ride (11)
    //    goto max(dest1, dest2) and open
    //    goto min(dest1, dest2) and open
    else if (done == 2'b10) // 1 is not done
    begin
      if (on_board == 2'b00 | on_board == 2'b10) target_floor_input = src1_input;
      else if (on_board == 2'b01 | on_board == 2'b11) target_floor_input = dest1_input;
    end
    else if (done == 2'b01) // 2 is not done
    begin
      if (on_board == 2'b00 | on_board == 2'b01) target_floor_input = src2_input;
      else if (on_board == 2'b10 | on_board == 2'b11) target_floor_input = dest2_input;
    end
    else begin end // IDLE State
  end


  // Output
  // assign current_floor_output = ev_floor;
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
