data = "data.csv"
holidays = "holidays.csv"
model = "model.csv"
set term png enhanced
set output "timeline.png"
reset

# This datafile line has to occur AFTER the reset command
# and is here solely for the github repo.
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
set title "Recovered and Active Cases in Provincetown\n{/*0.8 Source: Town of Provincetown}\n{/*0.7 Line Fit between 12/01 and 04/17 projects 131 recovered cases by Memorial Day}" font FONTSPEC

# Left y-axis (aka x1y1)
set ylabel 'Recovered Cases' font FONTSPEC
set yrange [0:]
set ytics nomirror

# Right y-axis (aka x1y2)
set y2label 'Active Cases' font FONTSPEC
set y2range [0:12] # manually include some whitespace for the ceiling
set y2tics 2 nomirror

# Legend font with sample line BEFORE y label title
set key font FONTSPEC left top reverse

# Define "linestyle n" or "ls n" specs for subsequent "plot data using"
set style line 1 lc rgb 'blue' lw 2
set style line 2 lc rgb 'orange' lw 3
set style line 3 lc rgb '#eeeeee' lw 2 # total
set style line 4 lc rgb 'gold' lw 1 # model

# Parens in the "using" clause indicate a formula or literal value
plot \
     model    using 1:2        with lines    title 'Line Fit'  axes x1y1 ls 4                               , \
     data     using 1:2        with impulses title 'Active'    axes x1y2 ls 2                               , \
     data     using 1:3        with lines    title 'Recovered' axes x1y1 ls 1                               , \
     data     using 1:3:4      with labels   notitle           axes x1y1 font LABELFONTSPEC offset 0,char 2 , \
     holidays using 1:(1.75):2 with labels   notitle           axes x1y2 font LABELFONTSPEC rotate by 90

     # Add this first for grey sum of Active and Recovered cases. Don't forget trailing comma+backslash.
     # data     using 1:($2+$3)  with lines    title 'Total'     axes x1y1 ls 3
