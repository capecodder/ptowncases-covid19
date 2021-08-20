data = "data.csv"
holidays = "holidays.csv"
model = "model.csv"
combinedpttr = "massdph-oc.csv"
set term png size 1024,1024
set output "timeline.png"
set datafile separator comma
LABELFONTSPEC = 'droid sans,8'
# Valid FONTSPECs are 'default', 'mono', 'humor sans' or
FONTSPEC = 'droid sans'

# Source data format
set timefmt '%Y-%m-%d' # source time
set xdata time
# set xrange ['2020-11-20':]

# Output data format
set xtics nomirror rotate by -60 format '%Y-%m-%d' # axis time

# Title and subtitle with font size change
# Remove model from display.
set title "Recovered and Active Cases in Provincetown\n{/*0.8 Sources: Town of Provincetown and Commonwealth of Massachusetts}" font FONTSPEC

# Left y-axis (aka x1y1)
set ylabel 'Recovered Cases' font FONTSPEC
set yrange [0:]
set ytics 10 nomirror

# Without left y-axis
#unset ylabel
#unset ytics

# Right y-axis (aka x1y2)
set y2label 'Active Cases' font FONTSPEC
set y2range [0:12] # manually include some whitespace for the ceiling
set y2tics 2 nomirror

# Legend font with sample line BEFORE y label title ("reverse")
set key font FONTSPEC left top # reverse

# Define "linestyle n" or "ls n" specs for subsequent "plot data using"
set style line 1 lc rgb 'blue' lw 2 # recovered
set style line 2 lc rgb 'orange' lw 3 # active
set style line 3 lc rgb '#eeeeee' lw 2 # total
set style line 4 lc rgb 'gold' lw 1 # model
set style line 5 lc rgb 'dark-green' lw 2 # Massachusetts DPH Total Case Count for both Provincetown and Truro

# Parens in the "using" clause indicate a formula or literal value
plot \
     data     using 1:2        with impulses title 'Active, Town-reported'    axes x1y2 ls 2                               , \
     data     using 1:3        with lines    title 'Recovered, Town-reported' axes x1y1 ls 1                               , \
     \
     data     using 1:3:4      with labels   notitle                          axes x1y1 font LABELFONTSPEC offset 0,char 0.5 , \
     holidays using 1:(1.00):2 with labels   notitle                          axes x1y2 font FONTSPEC rotate by 90           , \
     \
     combinedpttr using 1:5 with linespoints title 'Total Case Count for Provincetown and Truro, State-reported' axes x1y1 ls 5

     # Add this first for grey sum of Active and Recovered cases. Don't forget trailing comma+backslash.
     # data     using 1:($2+$3)  with lines    title 'Total'     axes x1y1 ls 3
     # Remove model from display.
     # model    using 1:2        with lines    title 'Line Fit'                 axes x1y1 ls 4
