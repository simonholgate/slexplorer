sub getStationData {

  use strict;

  my ($top, $sList, $ctryStnRef, $stnNameRef) = @_;
  my @entries = \$sList->curselection;
  my ($selected, $csCode, $sCode, $cCode, @orderFields);
  my (@selectFields, @items, @item, $corrected, $FNAME);
  my ($numStations, $minYear, $maxYear);
  my (@xLabel, @yearMean,@yearMeanArray, @data);

  my $definedData = 0;

  my @countryStationCode=@{$ctryStnRef};
  my @stationName=@{$stnNameRef};
  my @selectedStationNames;

  $canvas->delete( $im1, $im2, $im3 );

  # tie a scalar to the listbox to get the selection
  tie $selected, "Tk::Listbox", $sList, "ReturnType", "index";

  @selectedStationNames = @stationName[ @$selected ];

  foreach $csCode (@countryStationCode[ @$selected ]){ 
   
    ($cCode, $sCode) = split '/', $csCode;

    @selectFields = ( '*' );

    @orderFields = ( 'yr' );

    my $whereString = " where ccode = '$cCode' and scode = '$sCode' ";

    push @items, [query(\@selectFields, 'data', \@orderFields, $whereString)];
  }

  untie $selected;

  my @itemArray;
  my $i=0;
  my $j=0;

  $minYear = 0;
  $maxYear=0;

  while ( $i<=$#items) {
        @itemArray = @{$items[$i]};

	print "$#items, ${$items[$i][0]}[1]\n";
	while ( $j<=$#itemArray) {
	  @item = @{$itemArray[$j]};

	  if ($minYear==0){
	    $minYear=$item[2];
	  }
	  elsif ($minYear>$item[2]) {
	    $minYear = $item[2];
	  }
	  else {
	    $minYear = $minYear;
	  }

	  if ($maxYear<$item[2]){
	    $maxYear=$item[2];
	  }
	  else {
	    $maxYear = $maxYear;
	  }
	  # add RLR factor to mean if rlrData is set
          unless (defined $item[3]) {
	    $item[3] = 0;
          }
	  if (defined $item[17]) {
	    if ( $rlrData ) {
	      $corrected = $item[3] + $item[17];
	    }
	    else {
	      $corrected = $item[17];
	    }
	    $definedData = 1;
	  }
	  else {
	    undef $corrected;
	  }
          push @yearMean, $corrected;

	  $j++;
	}

	push @data, [@yearMean];
	$i++;
  };

  if ($definedData) {

    for ( $i=$minYear; $i<=$maxYear; $i++ ){
      push @xLabel, $i;
    }

    unshift @data, [@xLabel];

    $FNAME = pngImage(\@data, \@selectedStationNames);

    push @files, $FNAME;

    my $Image = $main->Photo(-format => 'png', -file => $FNAME);
    $im3 = $canvas->createImage('7.5c', '5c', -image => $Image);
    $canvas->pack(-expand => 1, -fill => 'both');


    $top->destroy;
  }
  else {
    
    my $text = "No yearly means available.\nPlease select another station.";
    $main->Dialog(-title => 'Selection error',
		  -text => $text,
		  -default_button => "Ok",
		  -buttons => [ "Ok" ],
		  -bitmap => 'error' )->Show();
  }
}
