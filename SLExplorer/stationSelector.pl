sub stationSelector {

  use strict;

  my @items;
  my @item;
  my @stationCode;
  my @stationName;
  my $selected;
  my $ccode;
  my @orderFields;
  my @selectFields;
  my $whereString;

  my ($cList, @countryCode) = @_;

  my @entries = $cList->curselection;

  # tie a scalar to the listbox to get the selection
  tie $selected, "Tk::Listbox", $cList, "ReturnType", "index";
 
  foreach $ccode (@countryCode[ @$selected ]){ 
     
    @selectFields = ( 'ccode', 'scode', 'sname' );

    if ($sCodeOrder == 1) {
      @orderFields = ( 'ccode', 'scode' );
    }
    elsif ( $gCodeOrder ) {
      @orderFields = ( 'xref1' );
      @selectFields = ( 'ccode', 'xref1', 'sname' );
    }
    else {
      @orderFields = ( 'ccode', 'sname' );
    }

    if ( $glossOnly ){

      $whereString = " where ccode = '$ccode' and XREF1 is not null ";

    }
    else {

      $whereString = " where ccode = '$ccode' ";

    }


    push @items, 
       query(\@selectFields, 'sttn', \@orderFields, $whereString) ;
  }

  untie $selected;

  my $i=0;
  while ( $i<=$#items) {
        @item = @{$items[$i]};
#	if ( $gCodeOrder ) {
#	  push @stationCode,  $item[1];
#	}
#	else {
	  push @stationCode,  $item[0]."/".$item[1];
#	}
        push @stationName, $item[2];
	$i++;
  };

  if (defined $stationCode[0]) { 
    # set up station selector window
    my $top1 = $main->Toplevel;

    my $checkButton1 = $top1->Checkbutton(
			  -text => 'RLR corrected data', 
		          -variable => \$rlrData
			  )->pack();

    # label window
    $top1->Label(-relief => 'raised',
	   -text => "Code   Station Name",
           -font => $font, 
 	  )->pack(-side => 'top', -expand => 1, -fill => 'x');

    $top1->title("Station Selector");

    my ($sList) = listbox($top1, \@stationCode, \@stationName);

    my $selectButton = $top1->Button(
       -text => "select",
       -font => $font,
       -command => sub{
       \&getStationData($top1, $sList, \@stationCode, \@stationName);
                      });

    # set up selector menu bar
    menuBar($top1);

    # show the listbox and select button
    $sList->pack(-fill => 'y', -expand => 1);
    $selectButton->pack(-fill => 'x'); 
 
    $csTopLevel->withdraw;
  }
  else {
    
    my $text = "No stations available.\nPlease select another country.";
    $main->Dialog(-title => 'Selection error',
		  -text => $text,
		  -default_button => "Ok",
		  -buttons => [ "Ok" ],
		  -bitmap => 'error' )->Show();
  }
}
