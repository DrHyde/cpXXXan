#!/usr/local/bin/perl

use warnings;
use strict;

use DBI;

my $cpxxxan = DBI->connect('dbi:SQLite:dbname=db/cpXXXan');
my $testresults = DBI->connect('dbi:SQLite:dbname=db/cpanstatsdatabase');

my $results = $testresults->selectall_arrayref(
    q{SELECT id, dist, version, perl FROM cpanstats WHERE state='pass' AND (dist LIKE 'DBI%' or dist LIKE 'DBD%')},
    {Slice => {}}
);

my $insert = $cpxxxan->prepare('
    INSERT INTO passes (id, dist, distversion, normdistversion, perl) VALUES (?, ?, ?, ?, ?)
');
my $select = $cpxxxan->prepare('SELECT id FROM passes WHERE id = ?');

foreach(@{$results}) {
    $select->execute($_->{id});
    if(!$select->fetchrow_array()) {
        $insert->execute(
            $_->{id}, $_->{dist}, $_->{version},
            eval { version->new($_->{version})->numify() } || 0,
            $_->{perl}
        );
        printf("id: %s\tdist: %s\tversion: %s\tperl: %s\n",
            $_->{id}, $_->{dist}, $_->{version}, $_->{perl});
    }
}
