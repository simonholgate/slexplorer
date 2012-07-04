sub fileMenuItems{
	
  use strict;

  my($fname, $FNAME);

  [
    [qw/command ~New -accelerator Alt-N/],		'',
    [qw/command ~Open -accelerator Alt-O -command/ => sub {
                      $fname = $main->getOpenFile();
                      if (!defined($fname)) {
                       $fname = "Cancel: No Chdir";
                      }
                     }],
    [qw/command ~Save -accelerator Alt-S/],
    [qw/command/, 'S~ave As ...', qw/ -accelerator Alt-A/],
    [qw/command ~Quit -accelerator Alt-Q -command/ => sub{
		      foreach $FNAME (@files){
		        unlink $FNAME;
                      }
		      $main->destroy}],
  ];
}
