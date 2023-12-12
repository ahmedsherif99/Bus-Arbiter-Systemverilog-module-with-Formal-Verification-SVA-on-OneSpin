package arbitration;
    parameter N_MASTERS = 3;
    typedef bit [N_MASTERS-1:0] arb_vector;
    parameter arb_vector NO_REQUEST = '{default: '0};
    parameter arb_vector NO_GRANT = '{default: '0};
endpackage