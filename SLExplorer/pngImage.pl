sub pngImage {

  use strict;
  use GD::Text;

  my ($dataRef, $stationNameRef) = @_;

  my ($a, $b, $gd, @data, @stationName, $nameString);
  my ($FNAME, $titleString, $xLabelSkip, $xMaxValue);

  # create a new graph
  my $graph = GD::Graph::linespoints->new(500, 300);

  @stationName = @{$stationNameRef};

  if ( $rlrData ) {
    $titleString="Revised Local Reference Sea Level Data."
  }
  else { 
    $titleString="Metric Sea Level Data."
  }
  # allocate some data
  @data = @{$dataRef};

  my (@xLabel) = @{$data[0]};
  if ($#xLabel>=70) {
    $xLabelSkip = 10;
  }
  elsif ($#xLabel>=35) {
    $xLabelSkip = 5;
  }
  else {
    $xLabelSkip = 3;
  }
  $xMaxValue = $xLabel[0] + int($#xLabel/$xLabelSkip)*$xLabelSkip + $xLabelSkip;
 
  $graph->set(
	     logo 	       => 'SLExplorer/images/psmsltext.png',
	     logo_position     => 'LL',
	     logo_resize       => '0.6',
             x_label           => 'Year',
             y_label           => 'Relative Sea Level',
             title             => $titleString,
             marker_size       => 1,
             y_label_skip      => 2,
	     x_tick_number     => 'auto',
	     legend_placement  => 'BR',
	     x_label_position  => 0.5
          );
  $graph->set_title_font(gdGiantFont);
  $graph->set_legend(@stationName),
  $graph->set_legend_font(gdSmallFont),

  $gd = $graph->plot(\@data);

  # set up filename based on yearday and time
  my($sec,$min,$hr,$md,$m,$y,$wd,$yearday,$isdst) = gmtime(time);
  $FNAME = "/tmp/tmpSLE".$yearday.$hr.$min.$sec.".png";
  
  # open file
  open FNAME, ">".$FNAME or die "can't open $FNAME: $!\n";
  binmode FNAME;

  # print image to file
  print FNAME $gd->png;

  close FNAME;

  return $FNAME;
}

