import arbitration::*;

module busmaster(input clk, reset, master_req, bus_grant, bus_ack, output bus_req);
    logic bus_req; //for procedural assignments to drive a net
    enum {IDLE, REQUESTING, GRANTED} state_s;

    always @(posedge clk or posedge reset) begin: ctrl
        if(reset) begin // always block triggered by reset
            state_s <= IDLE;
	    bus_req <= 0;
        end
        else begin // always block triggered by clk
            case (state_s)
                IDLE: begin
                    if (master_req) begin
                        state_s <= REQUESTING;
                        bus_req <= 1; 
                    end
                end
                REQUESTING: begin
                    if (bus_grant) begin
                        state_s <= GRANTED;
                        bus_req <= 0; 
                    end
                end
                GRANTED: begin
                    if (bus_ack) begin
                        state_s <= IDLE; 
                    end
                end           
            endcase
        end      
    end
endmodule