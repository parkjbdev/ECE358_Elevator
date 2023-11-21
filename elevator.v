`timescale 100ms / 100ms
module elevator(
  input door_open,
  // 00 or 11 = stationary, 01 = up, 10 = down
  input [1:0] updown,
  output wire door,
  output wire[2:0] floor
);
  reg[3:0] state;

  // State Machine 
  // Floors[2:0] are represented as gray code
  // MSB is the state of the door (0 = closed, 1 = open)
  parameter floor1_closed = 4'b0001;
  parameter floor2_closed = 4'b0011;
  parameter floor3_closed = 4'b0010;
  parameter floor4_closed = 4'b0110;
  parameter floor5_closed = 4'b0111;
  parameter floor1_open = 4'b1001;
  parameter floor2_open = 4'b1011;
  parameter floor3_open = 4'b1010;
  parameter floor4_open = 4'b1110;
  parameter floor5_open = 4'b1111;

  initial state = floor1_closed;

  always @(state or door_open or updown)
  begin
    case (state)
      floor1_closed:
        if (door_open) #10 state = floor1_open;
        else begin
          if (updown == 2'b01) #10 state = floor2_closed;
          else state = floor1_closed;
        end
      floor1_open: 
        if (door_open) state = floor1_open;
        else #10 state = floor1_closed;

      floor2_closed:
        if (door_open) #10 state = floor2_open;
        else begin
          if (updown == 2'b01) #10 state = floor3_closed;
          else if (updown == 2'b10) #10 state = floor1_closed;
          else state = floor2_closed;
        end
      floor2_open: 
        if (door_open) state = floor2_open;
        else #10 state = floor2_closed;

      floor3_closed:
        if (door_open) #10 state = floor3_open;
        else begin
          if (updown == 2'b01) #10 state = floor4_closed;
          else if (updown == 2'b10) #10 state = floor2_closed;
          else state = floor3_closed;
        end
      floor3_open: 
        if (door_open) state = floor3_open;
        else #10 state = floor3_closed;

      floor4_closed:
        if (door_open) #10 state = floor4_open;
        else begin
          if (updown == 2'b01) #10 state = floor5_closed;
          else if (updown == 2'b10) #10 state = floor3_closed;
          else state = floor4_closed;
        end
      floor4_open: 
        if (door_open) state = floor4_open;
        else #10 state = floor4_closed;

      floor5_closed:
        if (door_open) #10 state = floor5_open;
        else begin
          if (updown == 2'b10) #10 state = floor4_closed;
          else state = floor5_closed;
        end
      floor5_open: 
        if (door_open) state = floor5_open;
        else #10 state = floor5_closed;
    endcase
  end

  // Gray Code to Binary Conversion
  assign floor[2] = state[2];
  assign floor[1] = state[2] ^ state[1];
  assign floor[0] = state[2] ^ state[1] ^ state[0];
  assign door = state[3];

endmodule
