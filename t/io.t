print "1..1\n";
use IO::BLOB::Pg;
use DBI;

my $db;
$db = DBI->connect("dbi:Pg:dbname=mah", "", "", {RaiseError=>1, AutoCommit => 0});
die $DBI::errstr if $DBI::err;
eval {
  my $h = IO::BLOB::Pg->new($db);
  print $h "\n";
  foreach (1..10) {
    print $h "$_\n";
  }   
  my $id = $h->oid;
  $h->close;

  $h = IO::BLOB::Pg->open($db, $id);
  while(<$h>) {
    print "<$_>\n";
  }

  print "eof\n"
   if $h->eof;
  $h->close;
};

my $error = $@ if $@;

$db->disconnect
  if $db;
print "not "
  unless not defined $error && $_ ne "10";
print "ok 1\n";

