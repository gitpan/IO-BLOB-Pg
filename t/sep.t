print "1..1\n";
use IO::BLOB::Pg;
use DBI;

my $db;
$db = DBI->connect("dbi:Pg:dbname=mah", "", "", {RaiseError=>1, AutoCommit => 0});
die $DBI::errstr if $DBI::err;
eval {
  my $h = IO::BLOB::Pg->new($db);
  $/ = "x";
  print $h "\n";
  foreach (1..10) {
    print $h "$_", $/;
  }
  my $id = $h->oid;
  $h->close;

  $/ = "\n";
  $h = IO::BLOB::Pg->open($db, $id);
  while(<$h>) { $line = $_ }
  $h->close;
};
$db->disconnect
  if $db;

my $error = $@ || "";
print "not "
  unless $error eq "" && $line eq "1x2x3x4x5x6x7x8x9x10x";
print "ok 1\n";
