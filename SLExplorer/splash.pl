sub splash {

  use strict;

  $canvas = $main->Canvas(-background => 'white', 
			  -height => '10c',
			  -width => '15c');
  $main->title("PSMSL Sea Level Explorer");

  # set up splash menu bar
  mainMenuBar($main, 'white');

  my $waveImage=$main->Photo(-format => 'png', 
                        -file => 'SLExplorer/images/POLwave.png');
  $im1 = $canvas->createImage('0c','1c', -anchor => 'w', -image => $waveImage);
  my $psmslImage = $main->Photo(-format => 'png', 
                               -file => 'SLExplorer/images/psmsltext.png');
  $im2 = $canvas->createImage('15c','1c', -anchor => 'e', -image => $psmslImage);
  my $polImage = $main->Photo(-format => 'png', 
                               -file => 'SLExplorer/images/pol_logo50.png');
  $im3 = $canvas->createImage('7.5c','5c', -image => $polImage);

  # show the splash screen
  $canvas->pack(-expand => 1, -fill => 'both', -ipadx => '1c');

}
