sub tlFileMenuItems{
	
  use strict;

  my($top) = @_;

  [
    [qw/command ~Close -accelerator Alt-c -command/ => sub{
		      $top->destroy}],
  ];
}
