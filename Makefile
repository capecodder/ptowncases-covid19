# GNU Make 4.3

# Tested gnuplot 5.4 patchlevel 1
GNUPLOT=gnuplot

timeline.png: timeline.gnuplot data.csv holidays.csv model.csv
	$(GNUPLOT) $<
