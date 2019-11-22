#ifndef __PLATFORM_CONFIG_H_
#define __PLATFORM_CONFIG_H_

#define STDOUT_IS_16550
#define STDOUT_BASEADDR XPAR_AXI_UART16550_0_BASEADDR

#define PLATFORM_EMAC_BASEADDR XPAR_AXI_ETHERNET_0_ETH_BUF_BASEADDR

#define PLATFORM_TIMER_BASEADDR XPAR_AXI_TIMER_0_BASEADDR
#define PLATFORM_TIMER_INTERRUPT_INTR XPAR_MICROBLAZE_0_AXI_INTC_AXI_TIMER_0_INTERRUPT_INTR
#define PLATFORM_TIMER_INTERRUPT_MASK (1 << XPAR_MICROBLAZE_0_AXI_INTC_AXI_TIMER_0_INTERRUPT_INTR)

#ifdef __PPC__
#define CACHEABLE_REGION_MASK 0xffffffff8008ff80
#endif

#endif
