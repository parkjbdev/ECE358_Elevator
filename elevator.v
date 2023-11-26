`timescale 100ms / 100ms
module elevator(
  input clk,
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
  parameter FLOOR1_CLOSED = 4'b0001;
  parameter FLOOR2_CLOSED = 4'b0011;
  parameter FLOOR3_CLOSED = 4'b0010;
  parameter FLOOR4_CLOSED = 4'b0110;
  parameter FLOOR5_CLOSED = 4'b0111;
  parameter FLOOR1_OPENED = 4'b1001;
  parameter FLOOR2_OPENED = 4'b1011;
  parameter FLOOR3_OPENED = 4'b1010;
  parameter FLOOR4_OPENED = 4'b1110;
  parameter FLOOR5_OPENED = 4'b1111;

  initial state = FLOOR1_CLOSED;

  always @(posedge clk or state or door_open or updown)
  begin
    case (state)
      FLOOR1_CLOSED:
        if (door_open) #10 state = FLOOR1_OPENED;
        else begin
          if (updown == 2'b01) #10 state = FLOOR2_CLOSED;
          else state = FLOOR1_CLOSED;
        end
      FLOOR1_OPENED:
        if (door_open) state = FLOOR1_OPENED;
        else #10 state = FLOOR1_CLOSED;

      FLOOR2_CLOSED:
        if (door_open) #10 state = FLOOR2_OPENED;
        else begin
          if (updown == 2'b01) #10 state = FLOOR3_CLOSED;
          else if (updown == 2'b10) #10 state = FLOOR1_CLOSED;
          else state = FLOOR2_CLOSED;
        end
      FLOOR2_OPENED:
        if (door_open) state = FLOOR2_OPENED;
        else #10 state = FLOOR2_CLOSED;

      FLOOR3_CLOSED:
        if (door_open) #10 state = FLOOR3_OPENED;
        else begin
          if (updown == 2'b01) #10 state = FLOOR4_CLOSED;
          else if (updown == 2'b10) #10 state = FLOOR2_CLOSED;
          else state = FLOOR3_CLOSED;
        end
      FLOOR3_OPENED:
        if (door_open) state = FLOOR3_OPENED;
        else #10 state = FLOOR3_CLOSED;

      FLOOR4_CLOSED:
        if (door_open) #10 state = FLOOR4_OPENED;
        else begin
          if (updown == 2'b01) #10 state = FLOOR5_CLOSED;
          else if (updown == 2'b10) #10 state = FLOOR3_CLOSED;
          else state = FLOOR4_CLOSED;
        end
      FLOOR4_OPENED:
        if (door_open) state = FLOOR4_OPENED;
        else #10 state = FLOOR4_CLOSED;

      FLOOR5_CLOSED:
        if (door_open) #10 state = FLOOR5_OPENED;
        else begin
          if (updown == 2'b10) #10 state = FLOOR4_CLOSED;
          else state = FLOOR5_CLOSED;
        end
      FLOOR5_OPENED:
        if (door_open) state = FLOOR5_OPENED;
        else #10 state = FLOOR5_CLOSED;
    endcase
  end

  // Gray Code to Binary Conversion
  assign floor[2] = state[2];
  assign floor[1] = state[2] ^ state[1];
  assign floor[0] = state[2] ^ state[1] ^ state[0];
  assign door = state[3];

endmodule
