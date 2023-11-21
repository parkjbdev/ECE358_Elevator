`timescale 100ms / 100ms

module testbench;
    // Define inputs and outputs for the test bench
    reg clk;
    reg door_open;
    reg [1:0] updown;
    wire [2:0] floor;
    wire door;
    wire [3:0] state;

    // Instantiate the elevator module
    elevator elev(.clk(clk), .door_open(door_open), .updown(updown), .floor(floor), .door(door), .state(state));

    // Generate clock signal
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 100ms period clock signal
    end

    // Test scenarios
    initial begin
        // Initial state
        door_open = 0;
        updown = 2'b00;
        #100; // Wait

        // Open door at floor 1
        door_open = 1;
        #100; // Wait

        // Close door at floor 1 and move to floor 2
        door_open = 0;
        updown = 2'b01;
        #100; // Wait

        // Open door at floor 2
        door_open = 1;
        #100; // Wait

        // Close door at floor 2 and move to floor 1
        door_open = 0;
        updown = 2'b10;
        #100; // Wait

        // End of simulation
        $finish;
    end

    // Monitor state changes
    initial begin
        $monitor("Time: %g, Clock: %b, Door: %b, Floor: %d, State: %b", $time, clk, door, floor, state);
    end
endmodule
