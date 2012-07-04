sub query {

  # select args(0) from the table in arg(1) ordered by args(2)
  use DBI;
  use strict;

  my @array = ();
  my (@args) = @_;
  my $selectFields;
  my $orderFields;

  my @select_fields=@{$args[0]};
  my @order_fields=@{$args[2]};

  my $i=0;
  while ($i<=$#select_fields) {
    if ( $i == 0 ){
      $selectFields = $select_fields[$i];
    }
    else {
      $selectFields = join ',', $selectFields ,$select_fields[$i];
    }
    $i++;
  }
 
  $i=0;
  while ($i<=$#order_fields) {
    if ( $i == 0 ){
      $orderFields = $order_fields[$i];
    }
    else {
      $orderFields = join ',', $orderFields ,$order_fields[$i];
    }
    $i++;
  }
 
  my $dbh = DBI->connect('DBI:Oracle:', 'user', 'pass',
        { RaiseError => 1, AutoCommit => 0 })
        or die $DBI::errstr;
  my $statement = qq{
        select $selectFields
        from $args[1]
  };

  if ( $#args > 2 ){

      $statement = $statement . $args[3]

  }

  $statement = $statement . qq{	order by $orderFields };

  my $sth = $dbh->prepare($statement);
  my $rc = $sth->execute;

  while ( my @row = $sth->fetchrow_array ) {
        push @array, [ @row ];
  }

  $sth->finish;
  $rc = $dbh->disconnect or warn $dbh->errstr;

return @array;
}
