require 5.005_03;  # need self-tie patch

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME	 => 'IO::BLOB::Pg',
    VERSION_FROM => 'lib/IO/BLOB/Pg.pm',
    dist         => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
