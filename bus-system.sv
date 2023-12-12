import arbitration::*;
module top (input clk, reset, waitstate, input arb_vector master_req);
    
    arb_vector bus_req, bus_grant;
    logic bus_ack;

    busarbiter arbiter(.clk(clk), .reset(reset), .bus_req(bus_req), .bus_grant(bus_grant), .bus_ack(bus_ack));
    busslave slave(.clk(clk), .reset(reset), .waitstate(waitstate), .bus_grant(bus_grant), .bus_ack(bus_ack));
    busmaster master0(.clk(clk), .reset(reset), .master_req(master_req[0]), .bus_req(bus_req[0]), .bus_grant(bus_grant[0]), .bus_ack(bus_ack));
    busmaster master1(.clk(clk), .reset(reset), .master_req(master_req[1]), .bus_req(bus_req[1]), .bus_grant(bus_grant[1]), .bus_ack(bus_ack));
    busmaster master2(.clk(clk), .reset(reset), .master_req(master_req[2]), .bus_req(bus_req[2]), .bus_grant(bus_grant[2]), .bus_ack(bus_ack));
endmodule
    