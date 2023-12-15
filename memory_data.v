// All writes occur on rising clock edge.
// Concurrent read and write not allowed.
//
// On reset, memory loads from file "loadfile_all.img".
// (You may change the name of the file in
// the $readmemh statement below.)
// File format:
//     @0
//     <hex data 0>
//     <hex data 1>
//     ...etc
//
//
//////////////////////////////////////

module memory_data (data_out, data_in, addr, enable, wr, clk, rst);

   parameter ADDR_WIDTH = 16;
   output  [15:0] data_out;
   input [15:0]   data_in;
   input [ADDR_WIDTH-1 :0]   addr;
   input          enable;
   input          wr;
   input          clk;
   input          rst;
   wire [15:0]    data_out;
   
   reg [15:0]      mem [0:2**ADDR_WIDTH-1];
   reg            loaded;
   
   assign         data_out = (enable & (~wr))? {mem[addr[ADDR_WIDTH-1 :1]]}: 0; //Read
   initial begin
      loaded = 0;
   end

   always @(posedge clk) begin
      if (rst) begin
         if (!loaded) begin
            $readmemh("loadfile_mem.img", mem);
            loaded = 1;
         end
          
      end
      else begin
         if (enable & wr) begin
	        mem[addr[ADDR_WIDTH-1 :1]] = data_in[15:0];       // The actual write
           $display("Data in: %h", data_in);
         end
      end
   end


endmodule 
