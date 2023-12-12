import arbitration::*;

module busarbiter(input clk, reset, bus_ack, input arb_vector bus_req, output arb_vector bus_grant);
    
    enum {READY, BUSY} state_s;
    arb_vector prio_req;
    reg found;
    always @(bus_req) begin: prio
        arb_vector prio_req_v;
	found = 0;
        for (int i=0; i < N_MASTERS; i++) begin
            if(~found & (bus_req[i]==1'b1)) begin
                prio_req_v[i] = 1'b1;
                found = 1;
            end
            else begin
                prio_req_v[i] = 1'b0;
            end
        end
        prio_req <= prio_req_v;
    end

    always @(posedge clk or posedge reset) begin: ctrl
        if(reset) begin //always block triggered by reset
            state_s <= READY;
            bus_grant <= NO_GRANT;
        end
        else begin //always block triggered by clk
            case (state_s)
                READY: begin
                    if (bus_req == NO_REQUEST) begin
			state_s <= READY;
                    end
                    else begin
                        state_s <= BUSY;
                    end 
                    bus_grant <= prio_req;
                end

                BUSY: begin
                    if (bus_ack) begin
                        if (bus_req == NO_REQUEST) begin
                            state_s <= READY;
                        end
                        else begin
                            state_s <= BUSY;
                        end 
		        bus_grant <= prio_req;
		    end
                end
            endcase 
        end
    end
endmodule