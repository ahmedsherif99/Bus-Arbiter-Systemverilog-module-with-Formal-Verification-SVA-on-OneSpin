# Bus-Arbiter-Systemverilog-module-with-Formal-Verification-SVA-on-OneSpin

In this Project the correctness of the implementation of an arbiter in a bus system wa proved using Formal Verification assertion (sva) based on Design Specification that was provided along with the implementation of the module.

Design Specification
Fig. 1 shows the bus system with three masters, one slave and the arbiter to be verified. Masters may request bus access using their individual request signal. Only one master at a time is granted access by the arbiter. The bus transaction begins with the grant signal. The master deasserts its request signal after receiving the grant signal. The slave signals completion of the transaction by asserting its ack signal for the duration of one clock cycle. (After assertion, the ack signal goes low for at least one clock cycle.) The grant signal stays stable during the whole transaction. Another transaction can begin in the immediate clock cycle after the ack signal was asserted. The arbiter follows a static priority arbitration policy. Master 0 has the highest priority, Master 2 the lowest. Whenever more than one master requests bus access, the one with the highest priority wins arbitration.

![image](https://github.com/ahmedsherif99/Bus-Arbiter-Systemverilog-module-with-Formal-Verification-SVA-on-OneSpin/assets/68401714/07c3f5e4-350b-414d-81db-edc790f2d063)
