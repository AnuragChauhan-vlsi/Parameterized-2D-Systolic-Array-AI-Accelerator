module pe #(				//To make it parameterized
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 32
)(
    input clk,
    input rst,

    input clear_acc,

    input  [DATA_WIDTH-1:0] a_in,
    input  [DATA_WIDTH-1:0] b_in,

    output reg [DATA_WIDTH-1:0] a_out,
    output reg [DATA_WIDTH-1:0] b_out,

    output reg [ACC_WIDTH-1:0] result
);

always @(posedge clk)
begin

    if(rst)
    begin
        a_out  <= {DATA_WIDTH{1'b0}};
        b_out  <= {DATA_WIDTH{1'b0}};
        result <= {ACC_WIDTH{1'b0}};
    end

    else if(clear_acc)			//Clearing the accummulator of each PE, by keeping the data property the same
    begin
        result <= {ACC_WIDTH{1'b0}};
        a_out  <= a_in;
        b_out  <= b_in;
    end

    else
    begin
        a_out <= a_in;
        b_out <= b_in;

        result <= result + (a_in * b_in);		//MAC operation
    end

end

endmodule


module systolic_array #(
    parameter N          = 3,		//default value, can be changed while making the testbench and instantiating the DUT
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH  = 32
)(
    input clk,
    input rst,

    input clear_acc,

    input [N*DATA_WIDTH-1:0] a_in,
    input [N*DATA_WIDTH-1:0] b_in,

    output [N*N*ACC_WIDTH-1:0] c_out
);

genvar i,j;				//using it so that there would be no need to initialize or generate variables locally again and again

wire [DATA_WIDTH-1:0] a_bus [0:N-1][0:N];
wire [DATA_WIDTH-1:0] b_bus [0:N][0:N-1];

wire [ACC_WIDTH-1:0] result_bus [0:N-1][0:N-1];

generate

for(i=0;i<N;i=i+1)
begin : A_INJECT			//To not get confuse while loop is this, we are taking a default name of the loop

    assign a_bus[i][0]
        = a_in[(i*DATA_WIDTH)+:DATA_WIDTH];

end

endgenerate


generate

for(j=0;j<N;j=j+1)
begin : B_INJECT

    assign b_bus[0][j]
        = b_in[(j*DATA_WIDTH)+:DATA_WIDTH];

end

endgenerate

generate

for(i=0;i<N;i=i+1)
begin : ROW

    for(j=0;j<N;j=j+1)
    begin : COL

        pe #(					//intantiating our Processing Element in the design
            .DATA_WIDTH(DATA_WIDTH),
            .ACC_WIDTH (ACC_WIDTH)
        )
        PE
        (
            .clk(clk),
            .rst(rst),

            .clear_acc(clear_acc),

            .a_in (a_bus[i][j]),
            .b_in (b_bus[i][j]),

            .a_out(a_bus[i][j+1]),
            .b_out(b_bus[i+1][j]),

            .result(result_bus[i][j])
        );

    end

end

endgenerate

generate

for(i=0;i<N;i=i+1)			//output logic
begin : OUT_ROW

    for(j=0;j<N;j=j+1)
    begin : OUT_COL

        assign c_out[
            ((i*N+j)*ACC_WIDTH)
            +: ACC_WIDTH
        ]
        =
        result_bus[i][j];

    end

end

endgenerate

endmodule




