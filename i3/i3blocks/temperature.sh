#!/usr/bin/perl

# default values
my $t_warn = 70;
my $t_crit = 90;
my $chip = "";
my $temperature=(acpi -t | awk '{printf "%.1f°C", $4}')

# Print short_text, full_text
print "$temperature°C\n" x2;

# Print color, if needed
if ($temperature >= $t_crit) {
    print "#FF0000\n";
    exit 33;
} elsif ($temperature >= $t_warn) {
    print "#FFFC00\n";
}

exit 0;
