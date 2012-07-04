sub menuBar {
  
  use strict;

  my ($window, $colour) = @_;

  $window->configure(-menu => my $menu_bar = $window->Menu);

  my $file_mb = $menu_bar->cascade(
		-label => '~File', -menuitems => tlFileMenuItems($window));
  my $options_mb = $menu_bar->cascade(
		-label => '~Options', -menuitems => optionMenuItems());
  my $help_mb = $menu_bar->cascade(
		-label => '~Help', -menuitems => helpMenuItems());

  if ($colour) {
     $file_mb->configure(-background => $colour,
			-activebackground => $colour);
     $options_mb->configure(-background => $colour,
			-activebackground => $colour);
     $help_mb->configure(-background => $colour,
			-activebackground => $colour);
     $menu_bar->configure(-background => $colour);
  }

} 

