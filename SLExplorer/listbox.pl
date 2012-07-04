# set up listbox
sub listbox {

  use strict;

  my ($window, $ctryCode, $ctry) = @_;
  my @countryCode=@{$ctryCode};
  my @country=@{$ctry};

  my $wList = $window->Listbox(-relief => 'groove',
                  -setgrid => 'yes',
                  -selectmode => 'extended',
                  -exportselection => 0,
                  -font => $font,
                  -width => -1);

  # set up list
  my $i=0;
  while ( $i<=$#countryCode ) {
	$wList->insert("end", $countryCode[$i] . " " . $country[$i] );
	$i++;
  }

  # create scrollbar
  my $w_scroll = $window->Scrollbar(-command => ['yview', $wList])
	          ->pack(-side => 'right', -fill => 'y');

  # tie scrollbar to listbox
  $wList->configure( -yscrollcommand => ['set', $w_scroll]);

  return $wList;
}
