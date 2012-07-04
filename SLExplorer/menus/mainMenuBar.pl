sub mainMenuBar {
  
  use strict;

  my ($window, $colour) = @_;

  $window->configure(-menu => my $menu_bar = $window->Menu);

  my $file_mb = $menu_bar->cascade(
		-label => '~File', -menuitems => fileMenuItems());
  my $select_mb = $menu_bar->cascade(
		-label => '~Select', -menuitems => selectMenuItems());
  my $options_mb = $menu_bar->cascade(
		-label => '~Options', -menuitems => optionMenuItems());
  my $help_mb = $menu_bar->cascade(
		-label => '~Help', -menuitems => helpMenuItems());

  if ($colour) {
     $file_mb->configure(-background => $colour,
			-activebackground => $colour);
     $select_mb->configure(-background => $colour,
			-activebackground => $colour);
     $options_mb->configure(-background => $colour,
			-activebackground => $colour);
     $help_mb->configure(-background => $colour,
			-activebackground => $colour);
     $menu_bar->configure(-background => $colour);
  }

} 

