print "1..1\n";
use IO::BLOB::Pg;
use DBI;

my $db;
$db = DBI->connect("dbi:Pg:dbname=mah", "", "", {RaiseError=>1, AutoCommit => 0});
die $DBI::errstr if $DBI::err;
eval {
  my $h = IO::BLOB::Pg->new($db);
  print $h "SuperCalifragilistic";
  my $id = $h->oid;
  $h->close;

  $h = IO::BLOB::Pg->open($db, $id);
  $h->seek(3,0);
  $h->read($tmp, 10);
  print "not "
    if $tmp ne "erCalifrag";
  print "ok 1\n";
  $h->close;
};
$db->disconnect
  if $db;

my $error = $@ if $@;
print "not ok 1\n" if defined $error;;