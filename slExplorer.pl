#!/usr/bin/perl -w
#
# Tk script to interface to psmsl oracle database
#
  use Tk;
  use Tk::PNG;
  use Tk::Dialog;
  use GD;
  use GD::Graph::lines;
  use GD::Graph::linespoints;
  use vars qw($main $font $rlrData $glossOnly $cCodeOrder $csTopLevel
              $sCodeOrder $gCodeOrder $canvas $im1 $im2 $im3 @files);
  use strict;

  # subroutines
  do "SLExplorer/setEnv.pl";
  do "SLExplorer/splash.pl";

  # subroutines called from "mainMenuBar"
  do "SLExplorer/countrySelector.pl";
  do "SLExplorer/rangeSelector.pl";
  do "SLExplorer/searchStations.pl";

  # subroutines called from "countrySelector"
  do "SLExplorer/listbox.pl";
  do "SLExplorer/query.pl";
  do "SLExplorer/stationSelector.pl";

  # subroutines called from "stationSelector"
  do "SLExplorer/getStationData.pl";

  # subroutines called from "getStationData"
  do "SLExplorer/pngImage.pl";

  # menu subroutines
  do "SLExplorer/menus/menuBar.pl";
  do "SLExplorer/menus/mainMenuBar.pl";
  # subroutines called from "menuBar"
  do "SLExplorer/menus/fileMenuItems.pl";  # main file menu
  do "SLExplorer/menus/tlFileMenuItems.pl"; # top level file menu
  do "SLExplorer/menus/selectMenuItems.pl";
  do "SLExplorer/menus/optionMenuItems.pl"; 
  do "SLExplorer/menus/helpMenuItems.pl";

  my $FNAME;

  ($rlrData, $glossOnly, $cCodeOrder, $sCodeOrder, $gCodeOrder) = (1,0,0,0,0);
  @files = [ '/tmp/tmpSLE.png' ];
  $font ='-adobe-helvetica-medium-r-normal--12-120-75-75-p-67-iso8859-15';

  # set up splash screen
  $main = MainWindow->new;
  $main->protocol ('WM_DELETE_WINDOW', 
		sub{
			foreach $FNAME (@files){
		          unlink $FNAME;
                   	}
		      	$main->destroy;
		   }); 

  setEnv();
  splash();

  MainLoop;

__END__
#===============================================================================
#==== Documentation
#===============================================================================
=pod

=head1 NAME

SLExplorer - version 0.01 9 Jul 2002

A tool to visualise tidal data from the database of the Permanent Service for 
Mean Sea Level (PSMSL), based at Proudman Oceanographic Laboratory, UK.

=head1 SYNOPSIS

	./SLExplorer.pl

=head1 DESCRIPTION

Sea Level Explorer allows the user to select data from tidal stations around the world and to plot them for visual comparison. 

=head1 AUTHOR

Simon Holgate <simonh@pol.ac.uk>

=cut

