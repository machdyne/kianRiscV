// diamond 3.7 accepts this PLL
// diamond 3.8-3.9 is untested
// diamond 3.10 or higher is likely to abort with error about unable to use feedback signal
// cause of this could be from wrong CPHASE/FPHASE parameters
module pll #(
    parameter freq = 25
) (
    input clki, // 48 MHz, 0 deg
    output clko, // 50 MHz, 0 deg
    output locked
);
wire clkfb;
(* FREQUENCY_PIN_CLKI="48" *)
(* FREQUENCY_PIN_CLKOS="50" *)
(* ICP_CURRENT="12" *) (* LPF_RESISTOR="8" *) (* MFG_ENABLE_FILTEROPAMP="1" *) (* MFG_GMCREF_SEL="2" *)
EHXPLLL #(
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED"),
        .STDBY_ENABLE("DISABLED"),
        .DPHASE_SOURCE("DISABLED"),
        .OUTDIVIDER_MUXA("DIVA"),
        .OUTDIVIDER_MUXB("DIVB"),
        .OUTDIVIDER_MUXC("DIVC"),
        .OUTDIVIDER_MUXD("DIVD"),
        .CLKI_DIV(2),
        .CLKOP_ENABLE("ENABLED"),
        .CLKOP_DIV(25),
        .CLKOP_CPHASE(9),
        .CLKOP_FPHASE(0),
        .CLKOS_ENABLE("ENABLED"),
        .CLKOS_DIV(12),
        .CLKOS_CPHASE(0),
        .CLKOS_FPHASE(0),
        .FEEDBK_PATH("CLKOP"),
        .CLKFB_DIV(1)
    ) pll_i (
        .RST(1'b0),
        .STDBY(1'b0),
        .CLKI(clki),
        .CLKOP(clkfb),
        .CLKOS(clko),
        .CLKFB(clkfb),
        .CLKINTFB(),
        .PHASESEL0(1'b0),
        .PHASESEL1(1'b0),
        .PHASEDIR(1'b1),
        .PHASESTEP(1'b1),
        .PHASELOADREG(1'b1),
        .PLLWAKESYNC(1'b0),
        .ENCLKOP(1'b0),
        .LOCK(locked)
	);
endmodule
