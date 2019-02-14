#!/usr/bin/perl -w

use strict;
use Win32::PerfLib;
use Win32::Process;
use Getopt::Std;
use vars qw($opt_d);

#################
#
# killall.pl
#
# kill all processes by a certain name
# on windows.
#
# Run program without parameters
# for usage.
#

&print_usage() unless @ARGV;


# Get all process IDs by name.
my %process_by_name = &get_processes;

# Dump all available processes if -d :
getopts('d');
if($opt_d)
{
   print join "\n", sort keys %process_by_name;    
   exit;
}


# Sort through command line names:
foreach my $doomed (@ARGV)
{
   # Sort out matching processes:
   my @process_id = (map { /^$doomed$/i ? @{$process_by_name{$_}} : () } keys %process_by_name);
   
   if(!@process_id)
   {
       print "$doomed: no process killed\n";
       next;
   }

   # Blam! Take that, you lowly process you!    
   Win32::Process::KillProcess($_, 0) foreach(@process_id);
}

# Retrieves all process ID:s, sorted by name.
# Only slightly modified code from the
# Win32::PerfLib manpage, actually.
sub get_processes
{
   my (%counter, %r_counter, %process_by_name);
   
   Win32::PerfLib::GetCounterNames('', \%counter);
   
   %r_counter = reverse %counter;

   # Get id for the process object
   my $process_obj = $r_counter{'Process'};
   # Get id for the process ID counter
   my $process_id = $r_counter{'ID Process'};
   
   # create connection to local computer
   my $perflib = new Win32::PerfLib('');
   my $proc_ref = {};
   
   # get the performance data for the process object
   $perflib->GetObjectList($process_obj, $proc_ref);
   $perflib->Close();
   
   my $instance_ref = $proc_ref->{'Objects'}->{$process_obj}->{'Instances'};

   foreach my $instance (values %{$instance_ref})
   {
       my $counter_ref = $instance->{'Counters'};
       foreach my $counter (values %{$counter_ref})
       {
           if($counter->{'CounterNameTitleIndex'} == $process_id)
           {
               # Process ID:s stored by name, in anonymous array:
               push @{$process_by_name{$instance->{'Name'}}}, $counter->{'Counter'};
           }
       }
   }
   return %process_by_name;
}


sub print_usage
{
   print <<"USAGE";

Usage: $0 file [file_2...file_n]
      $0 -d
     
Filenames are caseinsensitive, but
must otherwise have all letters. So
if the process is named 'CMD', you can
whack it with 'CMD', 'cmd', or 'CmD'
for instance. However, you will not
whack 'WINCMD32' this way (a good thing).

In the *NIX tradition, when all goes well,
the program keeps quiet. It is when it
speaks, something is wrong. :)

The -d option dumps all the names that
are available, if you don't know the exact
name of the process you want to whack.


USAGE
exit;
}
