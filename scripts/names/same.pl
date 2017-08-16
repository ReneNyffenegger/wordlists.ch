#!/usr/bin/perl
use warnings;
use strict;

binmode(STDOUT, ":utf8");

open my $first_m, '<:encoding(utf8)', '../../data/names/first-m' or die;
open my $first_f, '<:encoding(utf8)', '../../data/names/first-f' or die;
open my $last   , '<:encoding(utf8)', '../../data/names/last'    or die;

my %names;

for (<$first_m>) { chomp; $names{ $_ }{m} = 1 }
for (<$first_f>) { chomp; $names{ $_ }{f} = 1 }
for (<$last>   ) { chomp; $names{ $_ }{l} = 1 }

print "Yes\n" if $names{l}{Andrea};

for my $name (sort keys %names) {

  if ( ( $names{$name}{m} and $names{$name}{f} ) or
       ( $names{$name}{m} and $names{$name}{l} ) or
       ( $names{$name}{f} and $names{$name}{l} ) ) {

     printf("%-30s %s %s %s\n",
              $name . '<',
       $names{$name}{m} ? 'm' : ' ',
       $names{$name}{f} ? 'f' : ' ',
       $names{$name}{l} ? 'l' : ' ');

  }


}
