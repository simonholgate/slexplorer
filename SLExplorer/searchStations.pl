sub searchStations{

  use strict;

  my @country;
  my @countryCode;
  my @listElement;
  my @item;
  my @orderFields;

  # get list of countries and country codes for pull down list
  my @selectFields = ( 'ccode', 'cname' );

  if ($cCodeOrder == 1) {
    @orderFields = ( 'ccode' );
  }
  else {
    @orderFields = ( 'cname' );
  }

  my @items = query(\@selectFields, 'ctry', \@orderFields);

  my $i=0;
  while ( $i<=$#items) {
        @item = @{$items[$i]};
	push @countryCode, $item[0];
        push @country, $item[1];
	$i++;
  };
  
  # set up country selector window
  my $top = $main->Toplevel;

  my $checkButton1 = $top->Checkbutton(
			  -text => 'GLOSS stations only', 
		          -variable => \$glossOnly
			  )->pack();

  # label selector window
  $top->Label(-relief => 'ridge',
	   -text => "Code  Country Name",
           -font => $font, 
	   -anchor => 'w',
 	  )->pack(-side => 'top', -expand => 1, -fill => 'x');

  $top->title("Country Selector");

  my ($cList) = listbox($top, \@countryCode, \@country);

  my $selectButton = $top->Button(
                          -text => "select",
                          -font => $font,
                          -command => sub{
		\&stationSelector($top, $cList, @countryCode);
                          });

  # set up selector menu bar
  menuBar($top);

  # show the listbox and select button
  $cList->pack(-fill => 'y', -expand => 1);
  $selectButton->pack(); 

}
