sub countrySelector{

  use strict;

  my $cList;
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
  if ( Exists($csTopLevel) ) {
    $csTopLevel->deiconify();
    $csTopLevel->raise();
  }
  else {
    $csTopLevel = $main->Toplevel;

    my $checkButton1 = $csTopLevel->Checkbutton(
			  -text => 'GLOSS stations only',
		          -variable => \$glossOnly
			  );
  
#  my $checkButton2 = $csTopLevel->Checkbutton(
#			  -text => 'Order by GLOSS code', 
#		          -variable => \$gCodeOrder,
#			  -anchor => 'nw',
#			  -command => sub{
#			if ( $gCodeOrder ) {
#			  $glossOnly = 1;
#			  $checkButton1->configure( -state => 'disabled' );
#			}
#			else {
#			  $checkButton1->configure( -state => 'normal' );
#			}
#					 }
#			  )->pack(-side => 'top', -expand => 1);
#  my $checkButton2 = $csTopLevel->Checkbutton(
#			  -text => 'Order by Country Code', 
#		          -variable => \$cCodeOrder,
#			  -command => sub{ 
#			$clist->destroy if Tk::Exists($clist);
#					 }
#			  )->pack(-side => 'top', -anchor => 'nw', -expand => 1);
    $checkButton1->pack(-side => 'top', -anchor => 'n', -expand => 1);

    # label selector window
    $csTopLevel->Label(-relief => 'ridge',
	   -text => "Code  Country Name",
           -font => $font, 
 	  )->pack(-side => 'top', -expand => 1, -anchor => 'n', -fill => 'x');

    $csTopLevel->title("Country Selector");

    $cList = listbox($csTopLevel, \@countryCode, \@country);

    my $selectButton = $csTopLevel->Button(
                          -text => "select",
                          -font => $font,
                          -command => sub{
		\&stationSelector($cList, @countryCode);
                          });

    # set up selector menu bar
    menuBar($csTopLevel);

    # show the listbox and select button
    $cList->pack(-fill => 'y', -expand => 1);
    $selectButton->pack(); 
  }

}
