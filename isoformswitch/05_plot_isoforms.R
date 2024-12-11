library(IsoformSwitchAnalyzeR)
# plot the isoform switch events of certain genes such as SRSF1
file <- '/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siSRRM2_ICM_WT_dIF0.3/part2.RData'
load(file)
pdf('/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siSRRM2_ICM_WT_dIF0.3/02_visualization/WT_vs_ICM/switch_plot_SRSF2.pdf',
    onefile = FALSE, height=6, width = 9)
switchPlot(
  mySwitchList,
  gene='SRSF2',
  condition1 = 'WT',
  condition2 = 'ICM',
  #localTheme = theme_bw(base_size = 8) # making text sightly larger for vignette
)
dev.off()
# plot SMC1A
file <- '/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siBANF1_siSRRM2_dIF0.1//part2.RData'
load(file)
pdf('/usr/users/yzhu1/www/0vF36w1M7UjV/HMGB2/Analysis/05_IsoformSwitch/siBANF1_siSRRM2_dIF0.1/02_visualization/ICM_vs_siSRRM2/switch_plot_SMC1A.pdf',
    onefile = FALSE, height=6, width = 9)
switchPlot(
  mySwitchList,
  gene='SMC1A',
  condition1 = 'ICM',
  condition2 = 'siSRRM2',
  #localTheme = theme_bw(base_size = 8) # making text sightly larger for vignette
)
dev.off()
