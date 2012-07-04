sub optionMenuItems{
	
  use strict;

  [
    ['cascade', 'Order by...', -menuitems =>
      [
        ['checkbutton', 'Country code', -variable => \$cCodeOrder],
        ['checkbutton', 'Station code', -variable => \$sCodeOrder],
        ['checkbutton', 'GLOSS code', -variable => \$gCodeOrder],
      ],
    ],
  ];
}
