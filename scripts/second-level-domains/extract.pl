#!/usr/bin/perl
use warnings;
use strict;

my $in_file  = shift;
my $out_dir  = shift;

die unless -e $in_file;
die unless -d $out_dir;

open my $in_h , '<', $in_file  or die;

my %slds;

while (my $line = <$in_h>) {

  chomp $line;

  if ($line =~ m{.*(?:://|www\.)([^/) :%;?,"]+).*}) {
    my $matched = lc $1;
    $matched =~ s/\.$//;
    $matched =~ m/^.*?([^.]+)\.([^.]+)$/;

    my $sld = $1;
    my $tld = $2;

    $slds{$tld}{$sld} = 1;
  }
# elsif ($line =~ m{www\..*([^.]+)\.([^. :;%?/!]+)}) {
#   my $sld = $1;
#   my $tld = $2;

#   $slds{$tld}{$sld} = 1;
# }

}


for my $tld (sort keys %slds) {

  next unless $tld;
  next if $tld =~ m/^\d+$/;
  next if length ($tld) == 2 and $tld ne 'ch';
  next if $tld eq 'asia';
  next if $tld eq 'cat';
  next if $tld eq 'gov';
  next if $tld eq 'int';
  next if $tld eq 'paris';
  next if $tld eq 'tokyo';

  print "tld: $tld\n";
  die "$out_dir/$tld already exists" if -e "$out_dir/$tld";
  open my $out_h, '>', "$out_dir/$tld" or die;

  for my $sld (sort keys %{$slds{$tld}}) {
    next if $sld eq 'facebook';
    next if $sld eq 'wikimedia';
    next if $sld eq 'wikipedia';
    next if $sld eq 'worldarchery';

    next if $tld eq 'info' and $sld eq 'usebitcoins';
    next if $tld eq 'info' and $sld eq 'schwarzwald-tourismus';

    next if $tld eq 'org'  and $sld eq 'hikr';
    next if $tld eq 'org'  and $sld eq 'ibsf';
    next if $tld eq 'org'  and $sld eq 'icrc';
    next if $tld eq 'org'  and $sld eq 'ifrc';
    next if $tld eq 'org'  and $sld eq 'ifsc-climbing';
    next if $tld eq 'org'  and $sld eq 'ilo';
    next if $tld eq 'org'  and $sld eq 'ismf-ski';
    next if $tld eq 'org'  and $sld eq 'isu';
    next if $tld eq 'org'  and $sld eq 'msf';
    next if $tld eq 'org'  and $sld eq 'jw';
    next if $tld eq 'org'  and $sld eq 'kingspizza';
    next if $tld eq 'org'  and $sld eq 'lds';
    next if $tld eq 'org'  and $sld eq 'mormon';
    next if $tld eq 'org'  and $sld eq 'oikumene';
    next if $tld eq 'org'  and $sld eq 'openstreetmap';
    next if $tld eq 'org'  and $sld eq 'osm';
    next if $tld eq 'org'  and $sld eq 'olympic';
    next if $tld eq 'org'  and $sld eq 'stoptb';
    next if $tld eq 'org'  and $sld eq 'unctad';
    next if $tld eq 'org'  and $sld eq 'unesco';
    next if $tld eq 'org'  and $sld eq 'unhcr';
    next if $tld eq 'org'  and $sld eq 'unitedworldwrestling';
    next if $tld eq 'org'  and $sld eq 'wbsc';
    next if $tld eq 'org'  and $sld eq 'wti';
    next if $tld eq 'org'  and $sld eq 'wto';
    next if $tld eq 'org'  and $sld eq 'zoo-infos';
    print $out_h "$sld.$tld\n";
  }

  close $out_h;
}
