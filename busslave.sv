import arbitration::*;
module busslave(input clk, reset, waitstate, input arb_vector bus_grant, output bus_ack);
    logic bus_ack; //for procedural assignments to drive a net
    enum {ACK, IDLE, BUSY1, BUSY2} state_s;

    always @(posedge clk or posedge reset) begin: ctrl //control FSM
        if (reset) begin // always block triggered by reset
	    state_s <= IDLE;
	    bus_ack <= 0;
        end
        else begin // always block triggered by clk
            case (state_s)
                ACK: begin
                    state_s <= IDLE; 
                    bus_ack <= 0;
                end 
		IDLE: begin
                    if (bus_grant != NO_GRANT) begin
                        state_s <= BUSY1;
                    end
                end
		BUSY1: begin
                    if (waitstate) begin
                        state_s <= BUSY2;
                    end
                    else begin
                        state_s <= ACK; 
                        bus_ack <= 1; 
		    end
                end
		BUSY2: begin
                    state_s <= ACK; 
                    bus_ack <= 1;
                end            
            endcase
        end
    end
endmodule