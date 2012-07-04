sub selectMenuItems{
	
  use strict;

  [
    [qw/command ~Country -accelerator Alt-C -command/ => sub{
	countrySelector();}
    ],
    [qw/command/, 'By ~Lat./Long. range', qw/-accelerator Alt-L -command/ => sub{
	rangeSelector();}
    ],
    [qw/command/, '~Search for station', qw/-accelerator Alt-S -command/ => sub{
	searchStations();}
    ],
  ];
}

