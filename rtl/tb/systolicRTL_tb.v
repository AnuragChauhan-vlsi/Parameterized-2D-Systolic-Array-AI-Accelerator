//Tb


module tb;

parameter N          = 3;
parameter DATA_WIDTH = 8;
parameter ACC_WIDTH  = 32;

reg clk;
reg rst;
reg clear_acc;

reg [N*DATA_WIDTH-1:0] a_in;
reg [N*DATA_WIDTH-1:0] b_in;

wire [N*N*ACC_WIDTH-1:0] c_out;

systolic_array #(
    .N(N),
    .DATA_WIDTH(DATA_WIDTH),
    .ACC_WIDTH(ACC_WIDTH)
)
dut
(
    .clk(clk),
    .rst(rst),

    .clear_acc(clear_acc),

    .a_in(a_in),
    .b_in(b_in),

    .c_out(c_out)
);

integer cycle = 0;

always @(posedge clk)
begin
    cycle = cycle + 1;

    $display("Cycle=%0d  C22=%0d",
              cycle,
              dut.result_bus[2][2]);
end

initial clk= 1'b0;
  always #5 clk= ~clk;

initial
begin

    rst       = 1;
    clear_acc = 0;

    a_in = 0;
    b_in = 0;

    repeat(2) @(posedge clk);

    rst = 0;

    clear_acc = 1;
    @(posedge clk);

    clear_acc = 0;

//cycle 0

    a_in = {8'd0, 8'd0, 8'd1};
    b_in = {8'd0, 8'd0, 8'd1};

    @(posedge clk);

//cycle 1

    a_in = {8'd0, 8'd4, 8'd2};
    b_in = {8'd0, 8'd2, 8'd4};

    @(posedge clk);

//cycle 2

    a_in = {8'd7, 8'd5, 8'd3};
    b_in = {8'd3, 8'd5, 8'd7};

    @(posedge clk);

//cycle 3

    a_in = {8'd8, 8'd6, 8'd0};
    b_in = {8'd6, 8'd8, 8'd0};

    @(posedge clk);

//cycle 4

    a_in = {8'd9, 8'd0, 8'd0};
    b_in = {8'd9, 8'd0, 8'd0};

    @(posedge clk);

    repeat(8)
    begin
        a_in = 0;
        b_in = 0;

        @(posedge clk);
    end

    $display("\nFINAL MATRIX");

    $display("%0d %0d %0d",
             dut.result_bus[0][0],
             dut.result_bus[0][1],
             dut.result_bus[0][2]);

    $display("%0d %0d %0d",
             dut.result_bus[1][0],
             dut.result_bus[1][1],
             dut.result_bus[1][2]);

    $display("%0d %0d %0d",
             dut.result_bus[2][0],
             dut.result_bus[2][1],
             dut.result_bus[2][2]);

    $stop;

end
endmodule
  
