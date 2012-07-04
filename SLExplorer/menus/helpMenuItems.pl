sub helpMenuItems{
	
  use strict;

  my($fname);

  [
    [qw/command ~New -font $font -accelerator Ctrl-n/],		'',
    [qw/command ~Open -font $font -accelerator Ctrl-o -command/ => sub {
                      $fname = $main->getOpenFile();
                      if (!defined($fname)) {
                       $fname = "Cancel: No Chdir";
                      }
                     }],
    [qw/command ~Save -font $font -accelerator Ctrl-s/],
    [qw/command/, 'S~ave As ...', qw/-font $font -accelerator Ctrl-a/],
    [qw/command ~Quit -font $font -accelerator Ctrl-q -command/ => sub{
		      $main->destroy}],
  ];
}
